ROOT_DIR ?= $(CURDIR)

RUN_WITH_IT ?= -it

.PHONY: image
apisix-test-nginx:
	docker build -t apisix-test-nginx -f ci/Dockerfile.apisix-test-nginx .

.PHONY: test
test:
	@docker run --rm ${RUN_WITH_IT} \
	-v ${ROOT_DIR}/apisix/t/plugin:/agw/apisix/t/ \
	-v ${ROOT_DIR}/apisix/plugins:/agw/apisix/plugins/ \
	apisix-test-nginx "/run-test-nginx.sh"