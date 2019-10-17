## dnmp

Docker + Nginx + MySQL + PHP 开发环境

选配服务：

- Redis

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

### PHP 扩展

`.env.sample` 文件中有少量的扩展安装事例，如要安装更多的扩展，编辑你的 `.env` 修改 `PHP_EXTENSIONS` 配置项

    # 要安装的扩展列表，用英文逗号隔开
    PHP_EXTENSIONS=pdo_mysql,mysqli,mbstring,gd,curl,redis

然后重新构建 `php` 镜像 `docker-compose build php` 启动服务 `docker-compose up -d`。可用的扩展列表请查看 `.env.sample` 的注释块说明

### 开发说明

Compose 文件格式: 3.7

> 采用本项目开发时 docker 官方推荐的最新版本，可 [参考](https://docs.docker.com/compose/compose-file/compose-versioning/)

### 需求列表

- [ ] 开源许可
- [ ] Nginx 支持 HTTPS
- [ ] Nginx 应用安装
- [x] 安装 PHP 扩展
- [ ] 容器时区
- [ ] PHP 多版本支持
    - [x] 7.2
    - [ ] 7.1
    - [ ] 5.6
- [x] MySQL 服务
- [x] Redis 服务
