# source
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git

# constants
> EROFS_BLKSIZ 1<< 12 = 4K
#1. erofs_buffer_init()
erofs_balloc(META, 0, 0, 0);
Args: meta: 1

# erofs_balloc
## 1. list_for_each_entry
list_for_each_entry(cur, &blkh.list, list) {
}
### 1.1 args
* struct erofs_buffer_block *cur,
* list: member name in struct erofs_buffer_block
* &blkh.list

```
// address of erofs_buffer_block.list
static struct erofs_buffer_block blkh = {
	.list = LIST_HEAD_INIT(blkh.list),
	.blkaddr = NULL_ADDR,
};

struct erofs_buffer_block {
	struct list_head list;
	erofs_blk_t blkaddr;
	int type;
	struct erofs_buffer_head buffers;
};
struct list_head {
	struct list_head *prev;
	struct list_head *next;
};
```
### 1.2 expansion
1. level 1
```
#define list_for_each_entry(pos, head, member)
for (pos = list_first_entry(head, typeof(*pos), member);
     &pos->member != (head);
     pos = list_next_entry(pos, member))

```
args:

* pos: pointer to struct element
* head: pointer to the member in the header element of struct.
* member: literal name of the member in struct.

## 2. list_first_entry

```CPP
pos = list_first_entry(head, typeof(*pos), member);
```
args:
    head: pointer to the member in the header element of struct.
    typeof(*pos): literal name of the struct element.
returns:
    pos: pointer to the first struct element
expansion:

```
#define list_entry(ptr, type, member) container_of(ptr, type, member)

#define list_first_entry(ptr, type, member) \
	list_entry((ptr)->next, type, member)
``` 
### 2.1 list_entry
disc: get a pointer to the struct element whose member pointer is ptr.
args:
    ptr: pointer to member **list** in struct.
    type: literal name of the struct element.
    member: literal name of the member in struct.
returns:
    pointer to the current struct element

## 3. list_next_entry
pos = list_next_entry(pos, member)
args:
    pos: pointer to current struct element
    member: literal name of the member in struct.
returns:
    pos: pointer to the next struct element
expansion:
```
#define list_next_entry(pos, member) \
	list_entry((pos)->member.next, typeof(*(pos)), member)
```

## 4. init_list_head
init_list_head(&bb->buffers.list);
args: a pointer to struct list_head
```
static inline void init_list_head(struct list_head *list)
{
	list->prev = list;
	list->next = list;
}
```
## 5. list_add_tail
list_add_tail(&bb->list, &blkh.list);

```
static inline void list_add_tail
(struct list_head *entry, struct list_head *head)
{
	__list_add(entry, head->prev, head);
}

__list_add(entry, head->prev, head)

static inline void 
__list_add(struct list_head *entry,
			      struct list_head *prev,
			      struct list_head *next)
{
	entry->prev = prev;
	entry->next = next;
	prev->next  = entry;
	next->prev  = entry;
}
```
## 6. __erofs_battach
> ret = __erofs_battach(bb, bh, size, alignsize, 
>              required_ext + inline_ext, false);
args:
struct erofs_buffer_block *bb,
struct erofs_buffer_head *bh,
size 0
alignsize: get_alignsize(type, &type); type =1
required_ext + inline_ext: 0
bool dryrun: false

prototype:
```CPP
static int __erofs_battach(struct erofs_buffer_block *bb,
   struct erofs_buffer_head *bh,
   erofs_off_t incr,
   unsigned int alignsize,
   unsigned int extrasize,
   bool dryrun)
```

### 6.1 roundup
const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize); // 0
args:
    bb->buffers.off: 0
    alignsize: 1
```CPP
#define roundup(x, y) (					\
{							\
	const typeof(y) __y = y;			\
	(((x) + (__y - 1)) / __y) * __y;		\
}
```
### 6.2 cmpsgn
const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
           alignsize) + incr + extrasize,
       EROFS_BLKSIZ);
= cmpsgn(0, 4K);
= -1

args:
* 1: 0

roundup(bb->buffers.off % EROFS_BLKSIZ,alignsize) + incr + extrasize

* EROFS_BLKSIZ: 4K

expansion:
```
#define cmpsgn(x, y) ({		\
	typeof(x) _x = (x);	\
	typeof(y) _y = (y);	\
	(_x > _y) - (_x < _y); })

```

# erofs_bh_balloon
err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
args:
* sb_bh
super block block_header (struct erofs_buffer_head *)
* EROFS_SUPER_END :1024 + 128 = 1152
Returns:
/* return occupied bytes in specific buffer block if succeed */ 1152
> #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))

## __erofs_battach
> __erofs_battach(bb, NULL, incr, 1, 0, false);
args:
    struct erofs_buffer_block *bb,
    struct erofs_buffer_head *bh = NULL;
    size incr = 1152
    alignsize: get_alignsize(type, &type); type =1
    required_ext + inline_ext: 0
    bool dryrun: false

const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
= roundup(0, 0) =0

const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
				       alignsize) + incr + extrasize,
			       EROFS_BLKSIZ);
 = cmpsgn(1152, 4k)
 = -1

bb.buffers.off = 1152
return 1152

# z_erofs_compress_init

## 1. erofs_compressor_init
int ret = erofs_compressor_init(&compresshandle,
					cfg.c_compr_alg_master);
args:
static struct erofs_compress * compresshandle;
char * c_compr_alg_master; //"lz4"
return 0; //for success

run:
compressor_lz4_init
```
struct erofs_compress {
	struct erofs_compressor *alg;

	unsigned int compress_threshold;

	/* *_destsize specific */
	unsigned int destsize_alignsize;
	unsigned int destsize_redzone_begin;
	unsigned int destsize_redzone_end;
	void *private_data;
};
```

==
compresshandle.alg = erofs_compressor_lz4;

# erofs_inode_manager_init

struct list_head inode_hashtable[NR_INODE_HASHTABLE]; //64

# erofs_build_shared_xattrs_from_path
args: char * path

## 1. erofs_count_all_xattrs_from_path
args: char * path


### 1.1 read_xattrs_from_file
read_xattrs_from_file(buf, NULL);
args: 
char * buf, file/dir path

1. llistxattr
ssize_t kllen = llistxattr(path, NULL, 0);
