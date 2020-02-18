#!/bin/bash

NUM_NODES=${NUM_NODES:-3}
VBOX_MEMORY=${VBOX_MEMORY:-2048}
VBOX_CPUS=${VBOX_CPUS:-1}
OVERLAY_SUBNET="10.10.0.0/24"

echo "Creating virtualbox.."
for i in m $(seq "${NUM_NODES}"); do
	docker-machine create \
		-d virtualbox \
		--virtualbox-memory ${VBOX_MEMORY} \
		--virtualbox-cpu-count ${VBOX_CPUS} \
		node-$i
done

echo "Initializing Swarm.."
eval $(docker-machine env node-m)
docker swarm init --advertise-addr $(docker-machine ip node-m)
TOKEN=$(docker swarm join-token -q worker)

for i in $(seq "${NUM_NODES}"); do
	eval $(docker-machine env node-$i)
	docker swarm join --token $TOKEN $(docker-machine ip node-m):2377
done

echo "Creating overlay network.."
eval $(docker-machine env node-m)
docker network create --driver overlay --subnet=${OVERLAY_SUBNET} overnet

echo "Adding labels for each node.."
docker node update --label-add frontend=true node-1
docker node update --label-add backend=true node-2
docker node update --label-add backend=true node-3

echo "Increating the limits on mmap.."
# https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
for i in $(seq "${NUM_NODES}"); do
	docker-machine ssh node-${i} "sudo sysctl -w vm.max_map_count=1048575 ;\
		sudo echo 'ulimit -n 262144' >> /etc/profile ;\
		"
done

echo -e "\n>> The Swarm Cluster is set up!"
