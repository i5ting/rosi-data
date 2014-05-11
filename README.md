# readme

准备数据

```
nohup ruby download.rb &
```

把nohup日志转成对应的sqlite3中

## 建表语句

```
sqlite3 db/development.sqlite3 'create table image_infos(id integer primary key autoincrement,path varchar(255),url varchar(255),title varchar(255),order_i integer,order_s varchar(10),face_image integer)
COMMIT;
```

具体字段说明如下：

- id integer primary key autoincrement

自增id主键

- path varchar(255)

路径，如`ROSI-1/ROSI-1-000.jpg`这个指的的本地图片文件路径

- url varchar(255)

服务器端图片url，如`http://pic.rosi.mn//image/00001/$.face.jpg`

- title varchar(255)

专辑名称，如`ROSI-1`

- order_i integer

专辑内图片[整型]编号，如`2`

- order_s varchar(10)

专辑内图片[字符型]编号，如`002`

- face_image integer

是否为封面图片，如`url = http://pic.rosi.mn//image/00001/$.face.jpg`的就是封面图片

## 运行

建库建表

```
rake dbmigrate
```

生成数据

```
rake run
```

清理数据

```
rake clean
```

默认行为
```
rake 
```

等价于

```
rake dbmigrate && rake run
```

## 技术

- ruby
- rake
- bundle
- sqlite3
- active record


## todo

- 缓存默认的album id(ok)
- 使用FastImageCache
