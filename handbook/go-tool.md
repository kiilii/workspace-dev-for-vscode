## golang tools 相关以及性能调试相关


### trace
`go tool trace` 使用 trace 需要获取程序运行时的 trace 信息。其中方法有多种

1. 代码插入 trace 跟踪代码，并写入文件
``` go
package main

import (
    ...
    "runtime/trace"
)

// 一个简单的例子去演示如何在代码中使用trace包
func main() {
    // 1. 创建trace持久化的文件句柄
    f, err := os.Create("trace.out")
    if err != nil {
        log.Fatalf("failed to create trace output file: %v", err)
    }
    defer func() {
        if err := f.Close(); err != nil {
            log.Fatalf("failed to close trace file: %v", err)
        }
    }()

    // 2. trace绑定文件句柄
    if err := trace.Start(f); err != nil {
        log.Fatalf("failed to start trace: %v", err)
    }
    defer trace.Stop()
    // code...
}
```


拿到 trace 信息文件后，直接使用命令就会出现 trace 页面的 http 地址
``` sh
go tool trace /you/path/trace.out
```
页面展示选项：
- View trace：查看跟踪
- Goroutine analysis：Goroutine 分析
- Network blocking profile：网络阻塞概况
- Synchronization blocking profile：同步阻塞概况
- Syscall blocking profile：系统调用阻塞概况
- Scheduler latency profile：调度延迟概况
- User defined tasks：用户自定义任务
- User defined regions：用户自定义区域
- Minimum mutator utilization：最低 Mutator 利用率

go tool trace更适合于找出程序在一段时间内正在做什么，而不是总体上的开销。

### pprof

`go tool pprof` 后面需要跟上 pprof 文件,即可进入 GDB console
``` sh
# goroutine
# threadcreate
# heap
# block

go tool pprof http://ip:port/debug/pprof/heap


# cpu 情况查看 默认30s
go tool pprof ./profile.out
go tool pprof ./profile.out -seconds 20

# http 可视化打开, 需安装 graphviz 插件
go tool pprof ./profile.out -seconds 20 -http [host]:[port]
```

进入 console 后比较常用的命令
- help
- top
- list $FuncName
- sort
- pdf (直接到处 pdf)
``` sh
(pprof): help

(pprof): top10

(pprof): list runtime.main
```
如果您想跟踪运行缓慢的函数，或者找到大部分CPU时间花费在哪里，go tool pprof，它可以显示在每个函数中花费的CPU时间的百分比。
### gctrace gc跟踪

只需要在运行命令前加 `GODEBUG=gctrace=1`
``` sh
GODEBUG=gctrace=1 go run main.go
gc 1 @0.027s 0%: 0.009+0.43+0.009 ms clock, 0.037+0.13/0.31/0.82+0.038 ms cpu, 4->4->0 MB, 5 MB goal, 4 P
gc 2 @0.048s 0%: 0.005+0.40+0.003 ms clock, 0.022+0.17/0.29/0.91+0.014 ms cpu, 4->4->0 MB, 5 MB goal, 4 P
……
gc 4 @0.063s 6%: 0.003+7.8+0.028 ms clock, 0.012+0.12/6.1/15+0.11 ms cpu, 23->24->22 MB, 24 MB goal, 4 P
gc 5 @0.121s 5%: 0.003+12+0.035 ms clock, 0.013+1.3/11/27+0.14 ms cpu, 42->43->40 MB, 44 MB goal, 4 P
……
gc 22 @25.651s 6%: 0.003+67+0.003 ms clock, 0.015+0/52/14+0.012 ms cpu, 156->156->74 MB, 211 MB goal, 4 P (forced)
scvg-1: 2740 MB released
scvg-1: inuse: 75, idle: 2740, sys: 2815, released: 2740, consumed: 75 (MB)
```
字段释义：
- gc 21: 21是垃圾回收的编号，逐步递增，可能会从1重新开始
- `@25.551s`: 自程序开始经历了多少时间,这里是25秒多
- 6%: 自程序启动花在GC上的CPU时间百分比, CPU 6%花在了GC上
- 0.012+59+0.010 ms clock: GC各阶段的墙上时间(wall-clock),各阶段包括STW sweep termination、concurrent mark and scan、STW mark termination
- 0.050+17/59/0.46+0.043 ms cpu: 各阶段的CPU时间。各阶段同上，其中mark/scan阶段又分成了assist time、background GC time和idle GC time阶段
- 175->207->105 MB: GC开始时、GC结束的heap大小、存活(live)的heap大小
- 191 MB goal:下一次垃圾回收的目标值
- 4 P: 使用的处理器的数量
- (forced): 强制垃圾回收， 程序中调用runtime.GC()或者类似操作
- scvg-1: 2740 MB released: gctrace的值大于0时，如果垃圾回收将内存返回给操作系统时，会打印一条summary,包括下一条数据


### go test 测试

go test 测试工具

- bench 基准测试
``` sh
# -bench 后接 regxp
go test -v -bench=. -benchtime=5s \
    -cpuprofile=cpu.out \
    -benchmem -memprofile memprofile.out \
    benchmark_test.go \
    -count=4 -cpu=8 -benchtime=500x # -benchtime 一组多少次; -count 测试几组; -cpu 几核心
```

- run 选择测试用例单独执行
``` sh
# 单独测试 file_test.go 下的 TestFuncA
go test -v -run TestFuncA file_test.go
```

- cover 开启测试覆盖率