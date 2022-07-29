## protobuf

### protoc 安装

``` sh
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install github.com/google/gnostic/cmd/protoc-gen-openapi@latest
```

### 使用事项

#### 导入
在 protobuf 文件编写时, 时常需要导入一些其他 proto 文件中的结构体，例如：

``` protobuf
syntax = "proto3";

package proto.example;

// 1 系统文件夹下，官方库文件
import "google/protobuf/timestamp.proto";
```

解决
``` sh
# -I 选项后加入相关 include 目录即可 使用
protoc --proto_path=/usr/local/Cellar/protobuf/3.19.4/include \
    --proto_path=${workspaceRoot}/proto \
    --go_out=paths=source_relative:${workspaceRoot}/proto/ \
    --go-grpc_out=paths=source_relative:${workspaceRoot}/proto\
```
