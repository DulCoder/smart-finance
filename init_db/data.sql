-- 权限表数据
insert  into `sys_permission`(`id`,`per_name`,`style`,`url`,`per_code`,`parent_id`,`icon`,`index_no`,`available`) values (2,'权限管理','1',NULL,NULL,0,'glyphicon-menu-hamburger',NULL,'1'),(3,'业务审核','1','m',NULL,0,'glyphicon-menu-hamburger',NULL,'0'),(4,'业务管理','1','u',NULL,0,'glyphicon-menu-hamburger',NULL,'1'),(5,'用户管理','1','user/index',NULL,2,'glyphicon-user',NULL,'1'),(6,'角色管理','1','role/index',NULL,2,'glyphicon-king',NULL,'1'),(7,'许可管理','1','permission/index',NULL,2,'glyphicon-lock',NULL,'1'),(8,'项目审核','1',NULL,NULL,3,'glyphicon-check',NULL,'1'),(9,'资质维护','1',NULL,NULL,4,'glyphicon-picture',NULL,'1'),(10,'广告审核','1','adv',NULL,3,'glyphicon-random',NULL,'1');

-- 角色表数据
insert  into `sys_role`(`id`,`role_name`,`remark`,`available`) values (5152208505,'root','超级管理员','1'),(5152208508,'user','普通用户','1'),(5152208509,'vip','会员用户','1');

-- 角色权限关联表数据
insert  into `sys_role_permission`(`id`,`sys_role_id`,`sys_permission_id`) values (51,'5152208505','2'),(52,'5152208505','5'),(53,'5152208505','6'),(54,'5152208505','7'),(55,'5152208505','3'),(56,'5152208505','8'),(57,'5152208505','10'),(58,'5152208505','4'),(59,'5152208505','9'),(60,'5152208508','0'),(61,'5152208508','2'),(62,'5152208508','5'),(63,'5152208508','3'),(64,'5152208508','8'),(65,'5152208508','10'),(66,'5152208508','4'),(67,'5152208508','9');

-- 用户表数据
insert  into `sys_user`(`id`,`user_acc`,`username`,`password`,`salt`,`create_time`,`last_login_time`,`locked`) values (5152208505,'smart','架构师','5d039dfe05247a36518f8e4a964e7229',NULL,'2018-05-27 14:49:40','2018-05-27 14:49:45','0'),(103242312891,'admin','管理员','c25baf3538db9cd490736598f88d2ad8',NULL,'2018-05-24 23:46:00','2018-05-24 23:46:04','0'),(13341522150937,'specime','Java工程师','cb15873d1eada59b7610a6af7a68f9b2',NULL,'2018-05-27 14:46:27','2018-05-27 14:46:30','0'),(13341522150940,'uTUser','测试账号1','546847aa6c9dc3e315afbde162b5aa41',NULL,'2018-05-27 18:01:29',NULL,'0');

-- 用户角色关联表数据
insert  into `sys_user_role`(`id`,`sys_user_id`,`sys_role_id`) values (1,'103242312891','5152208505'),(2,'13341522150937','5152208508');
