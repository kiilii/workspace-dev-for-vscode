## MySQL 基础

---------
### 查询

- 时间范围查询
``` sql
-- NOW() CURDATE() DATE_SUB/ADD(time, INTERVAL 1 DAY) TO_DAYS(NOW())
-- QUARTER(time) 季度 YEAR(time) 年度
-- 查询昨天
SELECT * FROM table_name WHERE TO_DAYS(date_columns) = TO_DAYS(date_columns) - 1
```

- 索引修改
``` sql
-- 创建
ALTER TABLE table_name ADD INDEX/UNIQUE/FULLTEXT/PRIMARY KEY idx_xxx

-- 删除
ALTER TABLE table_name DROP INDEX idx_xxx
DROP INDEX idx_xxx ON table_name
```

- 聚合函数
  聚合函数是指对一组值执行计算并返回单一的值的一类函数，它们通常与GROUP BY子句一起使用，将数据集分组为子集, 以下为最常见的五个
  - MIN
  - MAX
  - COUNT
  - AVG
  - SUM 

  聚合函数使用作用顺序
  > where > 聚合 > having
  
  聚合函数后可能无法where 无法准确命中，需要使用 `having` 来兜底
  >select dept_id,round(avg(salary),2)
from tb_emp
group by dept_id
having count(dept_id)>=3


----------

### 聚簇索引


### 数据页

页分裂 页合并

### mvcc



-------------

### 性能调优

下面内容为 mysql 状态检查、性能调优相关笔记

#### show 命令

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

#### EXPLAIN 参数解释

- filled
- index

----------

### 