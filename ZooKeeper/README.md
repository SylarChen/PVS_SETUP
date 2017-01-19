# Two VM Zookeeper cluster setup
1. prepare two VMs
2. edit /etc/hosts, make sure they are using the different fqdn.
3. install java (yum install java-1.8.0-openjdk* -y)
(on master)
4. wget http://mirrors.cnnic.cn/apache/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz (get zookeeper tar)
5. tar -xvzf zookeeper-3.4.8.tar.gz
6. cd zookeeper-3.4.8/
7. cp conf/zoo_sample.cfg conf/zoo.cfg (zookeeper default configuration file is conf/zoo.cfg)
8. append lines in conf/zoo.cfg: (server.A=B:C:D 其中A是一个数字，代表这是第几号服务器；B是服务器的IP地址；C表示服务器与群集中的“领导者”交换信息的端口；当领导者失效后，D表示用来执行选举时服务器相互通信的端口)
	* server.1=master:2888:3888
	* server.2=slave:2888:3888
9. scp -r ./zookeeper-3.4.8/ slave:~/ (copy whole folder to slave, including configuration file)
10. echo 1 > /tmp/zookeeper/myid (dataDir in conf/zoo.cfg, 这行命令用来标识当前节点的id)
(on slave)
11. echo 2 > /tmp/zookeeper/myid (dataDir in conf/zoo.cfg, 这行命令用来标识当前节点的id)

## Start, Stop, Status
* bin/zkServer.sh start start-foreground
* bin/zkServer.sh stop
* bin/zkServer.sh status

# Tutorial
* http://www.coderli.com/setup-kafka-cluster-step-by-step/
* http://www.cnblogs.com/smartloli/p/4298430.html
