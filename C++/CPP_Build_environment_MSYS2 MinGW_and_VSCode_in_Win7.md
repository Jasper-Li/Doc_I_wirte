# Win 7 下 C++ 编译环境 MSYS2 MinGW 64-bit + Visual Studio Code

## 1. MSYS2 
国内使用中科大的源，详见：https://lug.ustc.edu.cn/wiki/mirrors/help/msys2

> pacman -S mingw-w64-x86_64-toolchain

###1.1 踩过的坑
初始直接安装

> pacman -S gcc

而gcc -version 后发现是 7.4 而非 8.2 的。
后使用指令后版本变成 8.2 了。
> pacman -S mingw-w64-x86_64-gcc

但后来 gdb 时还需要手动安装一下。若空间足够，可以手动安装。
> pacman -S mingw-w64-x86_64-gdb

## 2. 使用 make 跑一下

test.cpp

```cpp
#include<iostream>

int main(void) {
    long int tag = __cplusplus;
    if(tag == 201703L) std::cout << "C++17\n";
    else if(tag == 201402L) std::cout << "C++14\n";
    else if(tag == 201103L) std::cout << "C++11\n";
    else if(tag == 199711L) std::cout << "C++98\n";
    else std::cout << "pre-standard C++\n";
    
    return 0;
}

```

makefile

```makefile
CPPFLAGS=-Wall -std=c++17
all:test
clean:
	rm test.exe
```

结果：
```bash
$ ./test.exe
C++17
```

## 3. 使用 Visual Studio Code
### 3.1 安装扩展：C/C++

### 3.2 新建文件夹
File -> Open Folder， Create a new Folder 'test'
create a new file test.cpp， the same as 2.

### 3.3 配置文件
create a dir .vscode with 3 files.
c_cpp_properties.json
```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "c:\\msys64\\mingw64\\include",
                "c:\\msys64\\mingw64\\lib\\gcc\\x86_64-w64-mingw32\\8.2.1\\include",
                "${workspaceFolder}/**"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "compilerPath": "C:\\msys64\\mingw64\\bin\\gcc.exe",
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "clang-x64"
        }
    ],
    "version": 4
}
```

用于编译的 tasks
tasks.json
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "g++",
            "type": "shell",
            "command": "g++",
            "args": [
                "${file}", "-g", "-o", "${fileDirname}/${fileBasenameNoExtension}.exe", "-std=c++17"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

用于运行加载的launch.json
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "c:\\msys64\\mingw64\\bin\\gdb.exe",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "g++"
        }
    ]
}
```

### 4. 编译
**快捷键：ctrl+shift+B**

**鼠标的用法：**
先选中 test.cpp
再Terminal -- Run Task -- g++ -- Continue...
Terminal 中会有编译成功的消息。

### 5. 运行 F5
会出现输出结果 
C++17

