# zig-and-go-simple-example
The `main.zig` is having both the signatures of the functions loaded from the libraryies, and the code itself, 
If the functions signatures are required to defined out of the `main.zig` then the `def.zig` file had been created (any name can be used), and the functions signatures had been defined as `pub` then this file (that contains tha definitions) had been imported at the main file, and the functions had been called using the source name as refernce, see the file `main2.zig`

**NOTE**
If both libraries having the same function, the the compiler will consider the one appearing at the first library that had been added at th e`build.zig`, i.e. if both libraries having a function named `add` and defined at the `build.zig` as:
```zig
    exe.linkSystemLibrary("libA");
    exe.linkSystemLibrary("libB");
 ```
 Then the functo `add` defined at the `libA` is the one to be considered, and the one defined at `libB` will be ignored, while if the libraries had been defined as:
```zig
    exe.linkSystemLibrary("libB");
    exe.linkSystemLibrary("libA");
 ``` 
Then the `add` function that had been defined at `libB` will be the one to be considered, and fucntion `add` defined at `libA` will be ignored.

The GO binary had been built as below to optimize the size:
```bash
 go build -ldflags "-w" main.go
 ```
 
 The zig file had been built using library, shared and static, this option is not available in GO,
 in GO you can not used a library generated from GO code into another GO code (excluding plugins which is not working at Windows)
 The lib generated from GO code can be called from another language but not from GO itself.
 
 The size of the GO lang generated binary is due to the GC (Garbage Collector) and run time, the size of ZIG generated binary is very minimal.
 
 The ZIG binary and Lib had been generated with optimized size using `.optimize = .ReleaseFast`
 
 To build the ZIG binary of both the lib and executable, created the `build.zig` file and run
 ```
 zig build
 ```
 In this repo as I used build.zig for the lib and then for the binary, I created two files, at the time of running the required file is required to be renamed from `build-xx.zig` to `build.zig`
 
![image](https://github.com/hajsf/zig-and-go-simple-example/assets/98168280/1fc04d83-7a27-4c7b-85d4-00b34d04d374)
