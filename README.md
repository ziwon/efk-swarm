# beats-swarm

## Visualizations

<img src="images/swarm-viz.png" />
<img src="images/metricbeats-system-dashboard.png" />
<img src="images/metricbeats-container-dashboard.png" />

## Usage

### swarm cluster up

```
$ make swarm-up
Creating virtualbox..
Running pre-create checks...
Creating machine...
(node-m) Copying /Users/luno/.docker/machine/cache/boot2docker.iso to /Users/luno/.docker/machine/machines/node-m/boot2docker.iso...
(node-m) Creating VirtualBox VM...
(node-m) Creating SSH key...
(node-m) Starting the VM...
(node-m) Check network to re-create if needed...
(node-m) Waiting for an IP...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with boot2docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env node-m
Running pre-create checks...
Creating machine...
(node-1) Copying /Users/luno/.docker/machine/cache/boot2docker.iso to /Users/luno/.docker/machine/machines/node-1/boot2docker.iso...
(node-1) Creating VirtualBox VM...
(node-1) Creating SSH key...
(node-1) Starting the VM...
(node-1) Check network to re-create if needed...
(node-1) Waiting for an IP...
...
```

### swarm cluster down
```
$ make swarm-down
About to remove node-1
WARNING: This action will delete both local reference and remote instance.
Successfully removed node-1
About to remove node-2
WARNING: This action will delete both local reference and remote instance.
Successfully removed node-2
About to remove node-3
WARNING: This action will delete both local reference and remote instance.
Successfully removed node-3
About to remove node-m
WARNING: This action will delete both local reference and remote instance.
Successfully removed node-m
```

### stack deploy
```
$ make stack-deploy
Creating service swarm_elasticsearch
Creating service swarm_kibana
Creating service swarm_metricbeat
Creating service swarm_filebeat
Creating service swarm_viz
Creating service swarm_listener
Creating service swarm_proxy
```

### stack process monitoring
```
$ watch make stack-ps
Every 2.0s: make stack-ps                                                                                                                                                                    lunos-MacBook-Pro.local: Sat Feb 16 12:33:29 2019

ID                          NAME                                             IMAGE                                                                                                                         NODE                DESIRED STATE
     CURRENT STATE            ERROR                       PORTS
fb037wmhpsz3et59qcpibgphr   swarm_filebeat.nes0yn0jnqtk8ebbgmepbml4x         docker.elastic.co/beats/filebeat:6.6.0@sha256:b2d8bec6dec4f2516b2dfba5481b655ee08adabd5d22e68667a38ae4f2e029d9                node-2              Running
     Running 21 minutes ago
0u2kjwmdih7wijppbjsfxgy4z   swarm_metricbeat.nes0yn0jnqtk8ebbgmepbml4x       docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-2              Running
     Running 21 minutes ago
9tx31ly1mnfh733li6q9u5sfl   swarm_filebeat.o1i0uh15b2034z509g8ig2jvx         docker.elastic.co/beats/filebeat:6.6.0@sha256:b2d8bec6dec4f2516b2dfba5481b655ee08adabd5d22e68667a38ae4f2e029d9                node-1              Running
     Running 21 minutes ago
o1ud3xc68rylfqiui09ir6zzk   swarm_filebeat.kolvqlj8z105ki1mtpz99yixm         docker.elastic.co/beats/filebeat:6.6.0@sha256:b2d8bec6dec4f2516b2dfba5481b655ee08adabd5d22e68667a38ae4f2e029d9                node-3              Running
     Running 21 minutes ago
hjofe5sbfqcg5m2ue6o7in3wz   swarm_metricbeat.o1i0uh15b2034z509g8ig2jvx       docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-1              Running
     Running 21 minutes ago
8esow33bwwa3if5yhw4jgowu5   swarm_metricbeat.kolvqlj8z105ki1mtpz99yixm       docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-3              Running
     Running 21 minutes ago
6n87vqvtggf5lmx9leflmhrxc    \_ swarm_metricbeat.kolvqlj8z105ki1mtpz99yixm   docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-3              Shutdown
     Failed 21 minutes ago    "task: non-zero exit (1)"
z5vk45s0hpfux4oo2ha9qcih7   swarm_metricbeat.nes0yn0jnqtk8ebbgmepbml4x       docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-2              Shutdown
     Failed 21 minutes ago    "task: non-zero exit (1)"
portqnxjc2atyvg2uspvkm52p   swarm_metricbeat.o1i0uh15b2034z509g8ig2jvx       docker.elastic.co/beats/metricbeat:6.6.0@sha256:5e0f78bcc95d81f956abf7817a347548e8178389edd4821f24b53c07ec60e301              node-1              Shutdown
     Failed 21 minutes ago    "task: non-zero exit (1)"
```

### stack service monitoring
```
$ watch make stack-service
Every 2.0s: make stack-service                                                                                                                                                               lunos-MacBook-Pro.local: Sat Feb 16 12:34:25 2019

ID                  NAME                  MODE                REPLICAS            IMAGE                                                 PORTS
3hdab90uffab        swarm_filebeat        global              4/4                 docker.elastic.co/beats/filebeat:6.6.0
b18qedtl68js        swarm_elasticsearch   replicated          2/2                 docker.elastic.co/elasticsearch/elasticsearch:6.6.0
glbk960768i7        swarm_metricbeat      global              4/4                 docker.elastic.co/beats/metricbeat:6.6.0
glmjj43pthla        swarm_proxy           replicated          1/1                 dockerflow/docker-flow-proxy:latest                   *:80->80/tcp, *:443->443/tcp, *:9200->9200/tcp
px01x5v87h7x        swarm_kibana          replicated          1/1                 docker.elastic.co/kibana/kibana:6.6.0
qkyzq7nsabk4        swarm_viz             replicated          1/1                 dockersamples/visualizer:latest
sf6k7mwmb56z        swarm_listener        replicated          1/1                 dockerflow/docker-flow-swarm-listener:latest
```

### show stack service logs
Use `make stack-logs [service-name-in-docker-compose-file]` to show log for each service.

```
 $ make stack-logs metricbeat
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.888Z    INFO    instance/beat.go:616    Home path: [/usr/share/metricbeat] Config path: [/usr/share/metricbeat] Data path: [/usr/share/metricbeat/data] Logs path: [/usr/share/metricbeat/logs]
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.891Z    INFO    instance/beat.go:623    Beat UUID: 470be3df-9b80-4b26-a202-e06ed6d1edc4
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.891Z    INFO    [seccomp]       seccomp/seccomp.go:116  Syscall filter successfully installed
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.892Z    INFO    [beat]  instance/beat.go:936    Beat info       {"system_info": {"beat": {"path": {"config": "/usr/share/metricbeat", "data": "/usr/share/metricbeat/data", "home": "/usr/share/metricbeat", "logs": "/usr/share/metricbeat/logs"}, "type": "metricbeat", "uuid": "470be3df-9b80-4b26-a202-e06ed6d1edc4"}}}
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.892Z    INFO    [beat]  instance/beat.go:945    Build info      {"system_info": {"build": {"commit": "2c385a0764bdc537b6dc078a1d9bf11bb6d7bd95", "libbeat": "6.6.0", "time": "2019-01-24T10:38:21.000Z", "version": "6.6.0"}}}
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.892Z    INFO    [beat]  instance/beat.go:948    Go runtime info {"system_info": {"go": {"os":"linux","arch":"amd64","max_procs":1,"version":"go1.10.8"}}}
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.893Z    INFO    [beat]  instance/beat.go:952    Host info       {"system_info": {"host": {"architecture":"x86_64","boot_time":"2019-02-15T21:50:16Z","containerized":true,"name":"node-m-metricbeat","ip":["127.0.0.1/8","10.10.0.94/24","172.18.0.6/16"],"kernel_version":"4.14.98-boot2docker","mac":["02:42:0a:0a:00:5e","02:42:ac:12:00:06"],"os":{"family":"redhat","platform":"centos","name":"CentOS Linux","version":"7 (Core)","major":7,"minor":6,"patch":1810,"codename":"Core"},"timezone":"UTC","timezone_offset_sec":0}}}
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.893Z    INFO    [beat]  instance/beat.go:981    Process info    {"system_info": {"process": {"capabilities": {"inheritable":["chown","dac_override","fowner","fsetid","kill","setgid","setuid","setpcap","net_bind_service","net_raw","sys_chroot","mknod","audit_write","setfcap"],"permitted":["chown","dac_override","fowner","fsetid","kill","setgid","setuid","setpcap","net_bind_service","net_raw","sys_chroot","mknod","audit_write","setfcap"],"effective":["chown","dac_override","fowner","fsetid","kill","setgid","setuid","setpcap","net_bind_service","net_raw","sys_chroot","mknod","audit_write","setfcap"],"bounding":["chown","dac_override","fowner","fsetid","kill","setgid","setuid","setpcap","net_bind_service","net_raw","sys_chroot","mknod","audit_write","setfcap"],"ambient":null}, "cwd": "/usr/share/metricbeat", "exe": "/usr/share/metricbeat/metricbeat", "name": "metricbeat", "pid": 1, "ppid": 0, "seccomp": {"mode":"filter","no_new_privs":true}, "start_time": "2019-02-16T03:12:21.730Z"}}}
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.893Z    INFO    instance/beat.go:281    Setup Beat: metricbeat; Version: 6.6.0
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.900Z    INFO    elasticsearch/client.go:165     Elasticsearch url: http://elasticsearch:9200
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.904Z    INFO    [publisher]     pipeline/module.go:110  Beat name: node-m-metricbeat
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.904Z    WARN    [cfgwarn]       docker/docker.go:54     BETA: The docker autodiscover is beta
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.905Z    WARN    [cfgwarn]       hints/metrics.go:59     BETA: The hints builder is beta
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.909Z    INFO    elasticsearch/client.go:165     Elasticsearch url: http://elasticsearch:9200
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.912Z    INFO    [monitoring]    log/log.go:117  Starting metrics logging every 30s
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.928Z    INFO    elasticsearch/client.go:721     Connected to Elasticsearch version 6.6.0
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:23.928Z    INFO    kibana/client.go:118    Kibana url: http://kibana:5601
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.848Z    INFO    instance/beat.go:741    Kibana dashboards successfully loaded.
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.849Z    INFO    instance/beat.go:403    metricbeat start running.
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.874Z    INFO    filesystem/filesystem.go:58     Ignoring filesystem types: sysfs, rootfs, tmpfs, bdev, proc, cpuset, cgroup, cgroup2, devtmpfs, binfmt_misc, configfs, debugfs, tracefs, sockfs, dax, bpf, pipefs, ramfs, hugetlbfs, rpc_pipefs, devpts, nfs, nfs4, autofs, 9p, mqueue, selinuxfs, vboxsf, overlay
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.874Z    INFO    fsstat/fsstat.go:59     Ignoring filesystem types: sysfs, rootfs, tmpfs, bdev, proc, cpuset, cgroup, cgroup2, devtmpfs, binfmt_misc, configfs, debugfs, tracefs, sockfs, dax, bpf, pipefs, ramfs, hugetlbfs, rpc_pipefs, devpts, nfs, nfs4, autofs, 9p, mqueue, selinuxfs, vboxsf, overlay
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.926Z    INFO    autodiscover/autodiscover.go:104        Starting autodiscover manager
swarm_metricbeat.0.m7njtkxqpa0x@node-m    | 2019-02-16T03:12:49.927Z    INFO    cfgfile/reload.go:150   Config reloader started
```

### delete stack
```
$ make stack-remove
Removing service swarm_elasticsearch
Removing service swarm_filebeat
Removing service swarm_kibana
Removing service swarm_listener
Removing service swarm_metricbeat
Removing service swarm_proxy
Removing service swarm_viz
```

### delete the swarm volumes
```
$ make swarm-remove-volume
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] Deleted Volumes:
swarm_kibana

Total reclaimed space: 113.8MB
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] Deleted Volumes:
swarm_elasticsearch

Total reclaimed space: 141.9MB
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] Deleted Volumes:
swarm_elasticsearch

Total reclaimed space: 141.6MB
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] Deleted Volumes:
swarm_metricbeat
swarm_filebeat

Total reclaimed space: 1.7kB
```
