# 一、需求
在 Windows 中使用 gVim 编写文档，内容较长时，索引起来不方便，希望能看到目录结构。

# 二、使用 vim-markdown 插件
## 1. 下载与安装

vim-markdown 主页：https://github.com/plasticboy/vim-markdown
[tar.gz 包下载](https://github.com/plasticboy/vim-markdown/archive/master.tar.gz)

```sh
cd ~/vimfiles
tar --strip=1 -zxf /path/to/vim-markdown-master.tar.gz
```
## 2. Configure
### 2.1 禁止自动折叠
```vim
let g:vim_markdown_folding_disabled = 1
```
### 2.2 目录窗口自适应

```vim
let g:vim_markdown_toc_autofit = 1
```

## 3. 使用

```
:Toc
```
# 三、新学的知识点
## 1. gVim 在 Windows 中插件路径
gVim 在 Windows 中插件路径为$HOME/vimfiles/
而在 Linux 中为 ~/.vim/
详见 
```vim
:help runtimepath
```

## 2. tar --strip

直接看结果，--strip=1 可以去掉 tar 文件夹的一层外壳，它是 --strip-components=1的缩写。
详见 man tar
```sh
$ mkdir default strip

$ tar xzf vim-markdown-master.tar.gz  -C default/

$ tar xzf vim-markdown-master.tar.gz -C strip/ --strip=1

$ ls strip/
after/           doc/       ftplugin/  Makefile   registry/  test/
CONTRIBUTING.md  ftdetect/  indent/    README.md  syntax/

$ ls default/
vim-markdown-master/

$ ls default/vim-markdown-master/
after/           doc/       ftplugin/  Makefile   registry/  test/
CONTRIBUTING.md  ftdetect/  indent/    README.md  syntax/
```
