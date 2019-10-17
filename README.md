## dnmp

Docker + Nginx + MySQL + PHP 开发环境

选配服务：

- Redis

### 目录结构

    ├── data                        数据目录
    ├── logs                        日志目录
    ├── services                    服务构建文件和配置文件目录
    │   ├── mysql
    │   ├── nginx
    │   ├── php
    │   └── redis
    ├── www                         开发目录
    ├── env.smaple                  环境配置示例文件
    └── docker-compose-sample.yml   Docker 服务配置示例文件

### 快速使用

1、软件依赖

- git
- docker 18.06.0+

2、`clone` 项目

    $ git clone https://github.com/dymyw/dnmp.git

3、配置、启动

    $ cd dnmp
    $ cp .env.sample .env
    $ cp docker-compose-sample.yml docker-compose.yml
    $ docker-compose up

4、修改 `hosts`，新增

    127.0.0.1       docker.lnmp
    127.0.0.1       docker.test

5、浏览器访问 `http://docker.lnmp` 或 `http://docker.test`

### 多域名支持

1、在 `.env` 配置项 `WWW_DIR` 指定的目录下，放置源代码

2、在 `services/nginx/conf.d/` 目录下添加相应的 `nginx` 配置文件

3、修改 `hosts`，新增映射

4、重启 `nginx` 服务

    $ docker exec -it dnmp_nginx_1 nginx -s reload

### PHP 扩展

`.env.sample` 文件中有少量的扩展安装事例，如要安装更多的扩展，编辑你的 `.env` 修改 `PHP_EXTENSIONS` 配置项

    # 要安装的扩展列表，用英文逗号隔开
    PHP_EXTENSIONS=pdo_mysql,mysqli,mbstring,gd,curl,redis

然后重新构建 `php` 镜像 `docker-compose build php` 启动服务 `docker-compose up -d`。可用的扩展列表请查看 `.env.sample` 的注释块说明

### 日志说明

所有的服务日志，统一放置在 `logs` 目录下

- mysql
    - mysql.error.log
    - mysql.slow.log
- nginx
    - access.log
    - error.log
    - 各站点的错误日志 ...
- php
    - fpm.slow.log
    - php.error.log
- redis
    - redis-server.log

#### Nginx 日志

在站点的配置中，指定日志到 `/var/log/nginx` 目录，如

    error_log /var/log/nginx/docker.lnmp-error.log warn;

### 生产环境使用

请注意

- 关闭 `php.ini` 的 xdebug 调试
- 增强 `MySQL` 访问的安全策略
- 增强 `Redis` 访问的安全策略

### 开发说明

Compose 文件格式: 3.7

> 采用本项目开发时 docker 官方推荐的最新版本，可 [参考](https://docs.docker.com/compose/compose-file/compose-versioning/)

### 需求列表

- [ ] 开源许可
- [ ] Nginx 支持 HTTPS
- [ ] Nginx 应用安装
- [x] 安装 PHP 扩展
- [x] 容器时区
- [ ] PHP 多版本支持
    - [x] 7.2
    - [ ] 7.1
    - [ ] 5.6
- [x] MySQL 服务
- [x] Redis 服务
