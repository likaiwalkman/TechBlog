```sql
test-while-idle: true
#获取连接时候验证，会影响性能
test-on-borrow: true
#在连接归还到连接池时是否测试该连接
test-on-return: true
#空闲连接回收的时间间隔，与test-while-idle一起使用，设置5分钟
time-between-eviction-runs-millis: 300000
#连接池空闲连接的有效时间 ，设置30分钟
min-evictable-idle-time-millis: 1800000
validation-query: SELECT 1
```
