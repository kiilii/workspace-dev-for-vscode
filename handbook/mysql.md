## MySQL 基础

### 聚簇索引


### 数据页

页分裂 页合并

### mvcc


### show 命令

``` sql
-- 显示一些系统特定资源的信息，例如，正在运行的线程数量
show status like 'Threads%';

-- 显示系统变量的名称和值
show variables;
show variables like '%max_connection%';

-- 显示mysql中所有数据库的名称
show databases;

-- 显示系统中正在运行的所有进程，也就是当前正在执行的查询。大多数用户可以查看
-- 他们自己的进程，但是如果他们拥有process权限，就可以查看所有人的进程，包括密码。
show processlist;

-- 显示当前使用或者指定的database中的每个表的信息。信息包括表类型和表的最新更新时间
show table status;

-- 显示一个用户的权限，显示结果类似于grant 命令
show grants for user_name@localhost;

-- 显示表的索引
show index from table_name;或show keys;

-- 显示一些系统特定资源的信息，例如，正在运行的线程数量
show status;

-- 显示服务器所支持的不同权限
show privileges;

-- 显示创建指定数据库的SQL语句
show create database database_name;

-- 显示创建指定数据表的SQL语句
show create table table_name;


-- 显示innoDB存储引擎的状态
show innodb status;

show logs;
-- 显示BDB存储引擎的日志

-- 显示最后一个执行的语句所产生的错误、警告和通知
show warnings;

-- 只显示最后一个执行语句所产生的错误
show errors;
```