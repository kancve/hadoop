# Introduction to the hadoop repo

Hadoop cluster environment.

## Build image

You can pull the generated image from the command line:

```bash
# pull images.
docker pull ghcr.io/kancve/hadoop/hadoop:3.2.2-ubuntu-16.04
# the name of the image is too long. I'll label it again.
docker tag ghcr.io/kancve/hadoop/hadoop:3.2.2-ubuntu-16.04 kancve/hadoop:3.2.2-ubuntu-16.04
```

Of course, you can also build it in your local environment.

You should note that the parameter ``HADOOP_VERSION`` specifies the version of hadoop and the parameter ``VERSION`` specifies the version of ubuntu.

```bash
docker build . -t kancve/hadoop:3.2.2-ubuntu-16.04 --build-arg HADOOP_VERSION=3.2.2 --build-arg VERSION=16.04
```

## Deploy cluster

Enter the ``deploy`` directory, execute command:

```bash
# initialize swarm.
docker swarm init
# start a service stack named kancve.
docker stack deploy -c hadoop-stack.yml -c system-stack.yml kancve
```

After startup successful, you can visit web pages of hadoop. (I use nginx's reverse proxy function.)

[hadoop-yarn](http://localhost/cluster)
[hadoop-hdfs](http://localhost/dfshealth.html)
[hadoop-jobhistory](http://localhost/jobhistory)
[hadoop-worker1](http://localhost/hadoop-worker1:8042)
[portainer](http://localhost/portainer)

enjoy it !
