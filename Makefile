SWARM_MASTER = node-m
STACK_NAME := elastic

define docker-env
$(foreach val, $(shell docker-machine env $1 | sed -e '/^#/d' -e 's/"//g'), $(eval $(val)))
endef

define get-node-ip
$(shell docker-machine ip $1)
endef

ifeq (stack-logs, $(firstword $(MAKECMDGOALS)))
  SERVICE := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(SERVICE):;@:)
endif

swarm-env:
	$(call docker-env, $(SWARM_MASTER))

swarm-up:
	@./scripts/swarm-up.sh

swarm-down:
	@docker-machine ls --format '{{.Name}}' | xargs -I {} docker-machine rm -f -y {} 2>/dev/null

swarm-remove-volume: swarm-env
	@for node in $$(docker node ls --format '{{.Hostname}}'); do \
		eval $$(docker-machine env $$node); \
		yes | docker volume prune; \
	done

swarm-viz:
	@open http://$(call get-node-ip, node-1)/viz

swarm-node: swarm-env
	@docker node ls

stack-deploy: swarm-env
	@docker stack deploy -c docker-compose.yml $(STACK_NAME)

stack-service: swarm-env
	@docker stack services $(STACK_NAME)

stack-ps: swarm-env
	@docker stack ps --no-trunc $(STACK_NAME)

stack-logs: swarm-env
	@docker service logs -f $(STACK_NAME)_$(SERVICE)

stack-remove: swarm-env
	@docker stack rm $(STACK_NAME)

kibana:
	@open http://$(call get-node-ip, node-1)

.PHONY: swarm-env swarm-up swarm-done swarm-remove-volume swarm-viz swarm-node stack-deploy stack-service stack-ps stack-logs stack-remove kibana

include .env
export
