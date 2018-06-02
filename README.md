# smart-finance
**RBAC权限系统**  
 多模块父子工程：spring+springmvc+mybatis+boostrap   
 通过自定义拦截器实现访问控制，并没有使用第三方权限框架
## 开发环境
- 编译工具：IntelliJ IDEA
- JDK： 1.8
- 数据库： MySQL57
- 连接池：druid1.1.6
- maven： 3.3.9
- spring： 4.3.12
- mybatis：3.4.1
- 字符编码： utf-8
- 前端：bootstrap3.3.7   

## 项目结构
- smart-parent：管理项目依赖，用于被其他模块继承，打包成pom
- smart-common：管理公共bean和工具类，打包成jar
- smart-manager：管理后台管理系统逻辑实现，打包成jar
- smart-web：管理项目入口，前端展示，打包成war

## 效果图  
![image](https://github.com/DulCoder/smart-finance/blob/master/readme/login.jpg)
![image](https://github.com/DulCoder/smart-finance/blob/master/readme/permisson.jpg)
![image](https://github.com/DulCoder/smart-finance/blob/master/readme/auser.jpg)
![image](https://github.com/DulCoder/smart-finance/blob/master/readme/arole.jpg)
