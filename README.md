# APISIX 相关


## 插件测试

```bash
# 构建单元测试镜像
make images
# docker build -t apisix-test-nginx -f ci/Dockerfile.apisix-test-nginx . 

# 执行单元测试
make test
#docker run --rm -it -v .\apisix\plugins\:/agw/apisix/plugins/ -v .\apisix\t\plugin\:/agw/apisix/t/ apisix-test-nginx "/run-test-nginx.sh"
```
