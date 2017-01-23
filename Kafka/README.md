# Two VM Kafka cluster setup
1. setup zookeeper cluster https://github.com/SylarChen/PVS_SETUP/blob/master/ZooKeeper/README.md <br />
(on master)
2. wget http://apache.claz.org/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
3. tar -xvf kafka_2.11-0.10.1.1.tgz
4. cd kafka_2.11-0.10.1.1
5. edit config/server.properties: <br />
//允许删除 topic <br />
delete.topic.enable=true <br />
//Kafka server id, 这里不能重复 <br />
broker.id=0 <br />
//这里要配置成本机的 hostname, 此处端口是kafka 生产者端口？<br />
listeners=PLAINTEXT://{hostname}:13647 <br />
//这里需要配置成外网能够访问的地址及端口 <br />
advertised.listeners=PLAINTEXT://{external.ip}:8080 <br />
log.dirs=/data/home/logger/kafka_2.11-0.10.0.0/kafka-logs <br />
num.partitions=2 <br />
//所有zookeeper的ip, zookeeper默认端口是2181 <br />
zookeeper.connect={zookeeper.master.ip}:2181,{zookeeper.slave.ip}:2181 <br />
6. scp -r ../kafka_2.11-0.10.1.1 {zookeeper.slave.ip}:~ <br />
(on slave)
7. edit config/server.properties

# Kafka commands
* bin/kafka-server-start.sh config/server.properties (start)
* bin/kafka-topics.sh --create --zookeeper {zookeeper.master.ip}:2181,{zookeeper.slave.ip}:2181 --replication-factor 2 --partitions 1 --topic test (create topic "test")
* bin/kafka-topics.sh --zookeeper {zookeeper.master.ip}:2181,{zookeeper.slave.ip}:2181 --list (list all topics)
* bin/kafka-console-producer.sh --broker-list {kafka.master.ip}:13647,{kafka.slave.ip}:13647 --topic test

# Tutorial
* http://wdxtub.com/2016/08/15/kafka-guide/
* http://www.coderli.com/setup-kafka-cluster-step-by-step/
