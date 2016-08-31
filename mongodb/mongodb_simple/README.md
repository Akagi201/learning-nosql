## mongod server 启动
* `cd mongodb_simple`
* `mongod -f conf/mongod.conf` or `mongod --config conf/mongod.conf`
* `numactl --interleave=all mongod -f conf/mongod.conf` // 我的3.2版本好像已经不需要这样启动了?

## mongo client 连接
* `mongo 127.0.0.1:12345/test`

## 关闭mongod
* `mongo> use admin` `mongo> db.shutdownServer()`
* `kill -15 <mongod-pid>` or `kill <mongod-pid>`

## 命令
* `show dbs` 显示所有数据库.
* `use imooc` 切换数据库. 在使用前不需要自己创建数据库, mongod 会自己创建.
* `db.dropDatabase()` 删除数据库.
* 插入数据: `db.imooc_collection.insert({x:1})` 参数为 json.
* `show collections` 显示当前数据库的所有的集合.
* `db.imooc_collection.find()` 查找记录.
* `db.imooc_collection.insert({x:2, _id:1})`
* `db.imooc_collection.insert({x:3, _id:1})` 报错.
* `db.imooc_collection.find({x:1})` 查找记录, 参数为 json.
* `for(i=3;i<100;i++)db.imooc_collection.insert({x:i})`
* `db.imooc_collection.find().count()` 计数.
* `db.imooc_collection.find().skip(3).limit(2).sort({x:1})`
* 更新数据: `db.imooc_collection.update({x:1}, {x:999})`
* 部分更新: `db.imooc_collection.update({z:100}, {$set:{y:99}})`
* 更新不存在的数据: `db.imooc_collection.update({y:100}, {y:999}, true)`, true: 表示如果我查找的数据不存在就自动insert一条.

## 更新
* `db.imooc_collection.insert({c:1})`
* `db.imooc_collection.insert({c:1})`
* `db.imooc_collection.insert({c:1})`
* `db.imooc_collection.find({c:1})`
* `db.imooc_collection.update({c:1}, {c:2})` 只会更新第一个{c:1} -> {c:2}
* 不允许全量更新, 只支持set操作: `db.imooc_collection.update({c:1}, {$set:{c:2}}, false, true)`

## 删除
* 删除必须带参数: `db.imooc_collection.remove()` 报错
* 是全删除: `db.imooc_collection.remove({c:2})`
* `db.imooc_collection.drop()`
* `show tables` 与 `show collections`有啥区别?

## 索引
* `db.imooc_collection.getIndexes()`
* 创建索引: `db.imooc_collection.ensureIndex({x:1})` x:1 表示正向排序, x:-1 表示逆向排序. 这样后续对x的查询速率是大大提高.
* 线上环境对于常用的查询, 必须创建相应的索引. 会降低一点写入性能.

## `_id` 索引
* `_id` 索引是绝大多数集合默认建立的索引.
* 对于每个插入的数据, `MongoDB`都会自动生成一条唯一的 `_id` 字段.
* `db.imooc_2.insert({x:1})`
* `db.imooc_2.getIndexes()`
* `db.imooc_2.findOne()`

## 单键索引
* 单键索引是最普通的索引.
* 与 `_id` 索引不同, 单键索引不会自动创建.
* `db.imooc_2.ensureIndex({x:1})` 创建索引.

## 多键索引
* 多键索引与单键索引创建形式相同, 区别在于字段的值.
* 单键索引: 值为一个单一的值, 例如字符串, 数字或日期.
* 多键索引: 值具有多个记录, 例如数组.
* `db.imooc_2.insert({x:[1,2,3,4,5]})`

## 复合索引
* 当我们的查询条件不只一个时, 就需要建立复合索引.
* 插入 `{x:1, y:2, z:3}` 记录 -> 按照 x 与 y 的值查询 -> 创建索引: `db.collections.ensureIndex({x:1, y:1})` -> 使用 `{x:1, y:1}` 作为条件进行查询.
