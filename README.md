### hail docker environment

### Note
This Dockerfile currently builds off fed768e78ac2ca06a50b6e1965d59d04d5a78e3e from https://github.com/hail-is/hail. This is the last version that used the CLI interface. If you want to use the latest hail and the python API see https://github.com/shusson/docker-pyhail

### Image
https://hub.docker.com/r/shusson/hail-alpine/ (based on 7e6855c)

### Examples

Mount sample data from the host machine, import vcf and count genotypes
```bash
docker run --rm -v /path/to/sample/data:/usr/work -w /usr/work shusson/hail-alpine importvcf \
src/test/resources/sample.vcf write -o sample.vds
...
docker run --rm -v $PWD:/usr/work -w /usr/work shusson/hail-alpine read sample.vds \
count --genotypes
...
```

Interactive
```bash
docker run -it --entrypoint=/bin/bash shusson/hail-alpine
root@aa43254a73ef:/ hail -h
...
```
