# zig-and-go-simple-example
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
