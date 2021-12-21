## 前言

请先阅读此文章 [业余时间如何开发一个App？出于好奇心QiShare带你体验一下](https://juejin.cn/post/6956462007474192392) 了解项目背景。

线上版本请点击 [https://music.jiudian.link](https://music.jiudian.link/#/)

## 目录结构

```
├── music_backend Java后端项目
├── data.sql 后端数据库脚本
└── music_theory Flutter客户端项目
```

## 服务端

### 环境

- JDK
- MySQL
- Redis（缓存验证码）
- 网易企业邮箱服务

> 用户注册需要短信验证码，短信成本较高，因此选择网易企业邮箱发送邮件验证码。关于如何申请网易企业邮箱服务，请参考 [SpringBoot–自定义域名发送邮件](https://juejin.cn/post/6844904097510850568)

### 数据库脚本

```mysql
创建数据库
CREATE DATABASE `music_theory` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
```

### 数据库脚本

创建表及插入基础数据，请执行 [data.sql](./data.sql)

### 基础配置

在 `application.properties` 中修改成你自己的配置：

```
pring.application.name=Music-Backend
server.port=8082
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/music_theory?charset=utf8mb4&useSSL=false&serverTimezone=GMT%2b8

#本地
spring.datasource.username=你的数据库用户名
spring.datasource.password=你的数据库密码

spring.jpa.properties.hibernate.hbm2ddl.auto=update
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5InnoDBDialect
#spring.jpa.show-sql=true


## 网易企业邮箱
spring.mail.host=smtp.ym.163.com
spring.mail.port=465
# 发件人的邮箱
spring.mail.username=你的发件人的邮箱
spring.mail.password=注意是企业邮箱的密码，企业邮箱没有授权码
spring.mail.properties.mail.smtp.ssl.enable=true
spring.mail.properties.mail.imap.ssl.socketFactory.fallback=false
spring.mail.properties.mail.smtp.ssl.socketFactory.class=javax.net.ssl.SSLSocketFactory
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.starttls.required=true
```

> 如果没有域名或不想用网易企业邮箱，只想本地体验的话，可以在控制台查看日志验证码实例如下：
>
> INFO 34157 --- [nio-8082-exec-1] l.j.m.controller.account.AuthController  : 验证码【7344】



## 客户端

### 环境

- flutter
- 其他根据需要自行安装，本人开发环境如下：

```
flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 2.8.0, on macOS 12.1 21C52 darwin-x64, locale
    zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version
    32.0.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 13.2.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2020.3)
[✓] IntelliJ IDEA Ultimate Edition (version 2019.2)
[✓] VS Code (version 1.62.3)
[✓] Connected device (3 available)

• No issues found!
```

## 配置

请求接口地址修改 `yueji/music_theory/lib/net/net_util.dart`

```dart
/// 本地运行请改成你的ip地址
static const String BASE_URL = "http://10.0.2.2:8082";

/// 线上服务器地址
static const String BASE_URL = "https://mapi.jiudian.link";
```







