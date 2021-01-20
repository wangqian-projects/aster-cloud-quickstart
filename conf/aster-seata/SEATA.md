# Seata 1.3 

入门地址:https://mp.weixin.qq.com/s/BOntA2mcdF-e0t2e4CBjPQ

视频教程:https://www.bilibili.com/video/BV1Cf4y1X7vR?t=83

## 介绍
常见的入门5大难题解析:

1.xid未传递 

2.数据源未代理

3.事务分组配置出错导致无法找到tc

4.Global lock acquire failed

5.Could not found global transaction xid

## 常见问题解析

**1.xid未传递** 

一般常见于springcloud的用户,请注意是否只引入了seata-all或者seata-spring-boot-starter.如果是,请换为本文介绍给springcloud的依赖即可.

如果是自己实现了WebMvcConfigurer,那么请参考com.alibaba.cloud.seata.web.SeataHandlerInterceptorConfiguration#addInterceptors把xid传递拦截器加入到你的拦截链路中

**2.数据源未代理**

一般分为2种情况

数据源自己创建后,代理数据源的beanname为DataSourceProxy而不是dataSource,导致sqlsessionfactory注入的并不是被代理后的.

如果是已经开启了自动代理的用户,请确认是否手写了sqlsessionfactory此时注入的DataSource并未显示是DataSourceproxy代理的情况,请进行调整,保证注入是代理的数据源.

**3.事务分组配置出错导致无法找到tc**

一般由于对事务分组的理解出现偏差导致的,请仔细阅读官网的参数配置中的介绍.

TM端: seata.tx-service-group=自定分组名 seata.service.vgroup-mapping(配置中心中是叫:service.vgroupMapping).自定分组名=服务端注册中心配置的cluster/application的值

拿nacos举例子

比如我server中nacos的cluster

```
  nacos {
    application = "seata-server"
    serverAddr = "localhost"
    namespace = ""
    cluster = "testCluster"
    username = "nacos"
    password = "nacos"
  }
```

我的事务分组为

```
seata:
  tx-service-group: test
```

那么nacos中需要配置test事务分组

```
service.vgroupMapping.test=testCluster
```

**4.Global lock acquire failed**

一般这种情况也是分为两种

常见的就是并没有对select语句进行forupdate,如果你不开启forupdate,seata默认是遇到并发性竞争锁并不会去尝试重试,导致拿不到lock当前事务进行回滚.不影响一致性,如果你想没forupdate也开启竞争锁client.rm.lock.retryPolicyBranchRollbackOnConflict设置为false(有死锁风险)

还有一种就是由于大并发下对同一个数据并发操作时,前一个事务还未提交,后续的事务一直在等待,而seata默认的超时周期为300ms,此时超时后就会抛出Global lock acquire failed,当前事务进行回滚,如果你想保住竞争锁的周期足够长,请更改client.rm.lock.retryTimes和client.rm.lock.retryInterval来保证周期的合理性.

**5.Could not found global transaction xid**

一般出现这个提示与服务重试及超时有关,比如A->B此时A调B超时,A默认是重试的,B等于被调了2遍,第二次被调用的B进行了响应,A发起者接收到结果后进行了提交/回滚,这次超时的B因为网络问题现在才被调用,他也收到了一样的全局事务id,进行业务处理,直到注册分支,此时全局事务已经被提交/回滚,导致当前超时的分支事务B无法注册上.

这种问题一般保证你的业务不会去超时重试,如果你需要,请确认全局事务状态,做好幂等,反正已经做过的处理重复操作.



打个tcc的比方，我有20块钱，有个朋友跟我借10块钱，说过一会跟我要，然后又来个朋友跟我借20块钱，但是我已经答应了a朋友要借他10块，所以我只剩下10块钱，但是我另外10块，那个朋友还没来要，我需要收起来。
事务成功：a朋友来拿钱来。（10-10=0）
事务失败：a朋友说他钱够了，不需要你借了（10+10=20）
资源预留：20-10（存储这10块到冻结字段） =10