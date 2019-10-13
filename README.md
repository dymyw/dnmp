## dnmp

Docker + Nginx + MySQL + PHP 开发环境

### 目录结构

    ├── logs                    日志目录
    ├── services                服务构建文件和配置文件目录
    │   ├── mysql
    │   ├── nginx
    │   └── php
    ├── www                     开发目录
    ├── env.smaple              环境配置示例文件
    └── docker-compose.yml      Docker 服务配置示例文件

### 快速使用

1、软件依赖

- git
- docker 18.06.0+

2、`clone` 项目

    $ git clone https://github.com/dymyw/dnmp.git

3、配置、启动

    $ cd dnmp
    $ cp .env.sample .env
    $ docker-compose up

4、修改 `hosts`，新增

    127.0.0.1       docker.lnmp
    127.0.0.1       docker.test

5、浏览器访问 `http://docker.lnmp` 或 `http://docker.test`

### 开发说明

Compose 文件格式: 3.7

> 采用本项目开发时 docker 官方推荐的最新版本，可 [参考](https://docs.docker.com/compose/compose-file/compose-versioning/)

### 需求列表

- [ ] 开源许可
- [ ] Nginx 支持 HTTPS
- [ ] 安装 PHP 扩展
