SHELL := $(shell which bash)
.SILENT: ;               # no need for @

include .env
export

define docker-env
$(foreach val, $(shell docker-machine env $1 | sed -e '/^#/d' -e 's/"//g'), $(eval $(val)))
endef

define get-node-ip
$(shell docker-machine ip $1)
endef

node-env:
	$(call docker-env, $(SWARM_MASTER))

node-up:
	./scripts/swarm-up.sh

node-down:
	docker-machine ls --format '{{.Name}}' | xargs -I {} docker-machine rm -f -y {} 2>/dev/null

node-cleanup: node-env
	for node in $$(docker node ls --format '{{.Hostname}}'); do \
		eval $$(docker-machine env $$node); \
		yes | docker volume prune; \
	done

node-viz:
	open http://$(call get-node-ip, node-1)/viz

node-status: node-env
	docker node ls

stack-start: node-env
	docker stack deploy -c docker-compose.yml $(STACK_NAME)

stack-service: node-env
	docker stack services $(STACK_NAME)

stack-ps: node-env
	docker stack ps --no-trunc $(STACK_NAME)

ifeq (stack-logs,$(firstword $(MAKECMDGOALS)))
  SERVICE := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(SERVICE):;@:)
endif
stack-logs: node-env
	docker service logs -f $(STACK_NAME)_$(SERVICE)

stack-stop: node-env
	docker stack rm $(STACK_NAME)

kibana:
	open http://$(call get-node-ip, node-1)

.PHONY: node-env node-up node-down node-cleanup node-viz node-status stack-start stack-service stack-ps stack-logs stack-stop kibana
