/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.53 : Database - shiro_demo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shiro_demo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shiro_demo`;

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operateor` varchar(20) DEFAULT NULL,
  `operateType` varchar(30) DEFAULT NULL,
  `operateDate` datetime DEFAULT NULL,
  `operateResult` varchar(10) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

/*Data for the table `log` */

insert  into `log`(`id`,`operateor`,`operateType`,`operateDate`,`operateResult`,`ip`) values (1,'sss','资料修改','2019-07-04 16:50:42','操作成功',NULL),(2,'sss','资料修改','2019-07-05 20:25:13','操作成功',NULL),(3,'sss','资料修改','2019-07-05 20:46:56','操作失败',NULL),(4,'sss','导入角色','2019-07-05 21:08:00','操作成功',NULL),(5,'sss','删除角色','2019-07-05 21:08:13','操作成功',NULL),(6,'sss','删除角色','2019-07-05 21:08:27','操作成功',NULL),(7,'sss','添加角色','2019-07-05 21:08:45','操作成功',NULL),(8,'sss','角色分配保存','2019-07-05 21:09:07','操作成功',NULL),(9,'sss','角色分配保存','2019-07-05 21:09:28','操作成功',NULL),(10,'sss','清空角色','2019-07-05 21:10:02','操作成功',NULL),(11,'sss','角色分配保存','2019-07-05 21:10:16','操作成功',NULL),(12,'sss','修改角色','2019-07-05 21:13:41','操作成功',NULL),(13,'koi','添加权限','2019-07-06 08:02:12','操作成功',NULL),(14,'koi','删除权限','2019-07-06 08:02:26','操作成功',NULL),(15,'koi','保存权限分配','2019-07-06 08:02:48','操作成功',NULL),(16,'koi','导出角色','2019-07-06 08:13:31','操作成功',NULL),(17,'koi','删除角色','2019-07-06 08:14:01','操作成功',NULL),(18,'koi','添加角色','2019-07-06 08:31:28','操作成功',NULL),(19,'koi','导出角色','2019-07-06 09:30:05','操作成功',NULL),(20,'koi','删除角色','2019-07-06 09:34:43','操作成功',NULL),(21,'koi','删除角色','2019-07-06 09:43:12','操作成功',NULL),(22,'koi','导出角色','2019-07-06 09:43:19','操作成功',NULL),(23,'koi','删除角色','2019-07-06 09:46:18','操作成功',NULL),(24,'koi','导出角色','2019-07-06 09:46:30','操作成功',NULL),(25,'koi','删除角色','2019-07-06 10:34:21','操作成功',NULL),(26,'koi','添加角色','2019-07-06 10:35:29','操作成功',NULL),(27,'koi','删除角色','2019-07-06 10:36:36','操作成功',NULL),(28,'koi','导出角色','2019-07-06 10:36:44','操作成功',NULL),(29,'koi','添加角色','2019-07-06 11:11:50','操作成功',NULL),(30,'koi','资料修改','2019-07-06 11:14:02','操作成功',NULL),(31,'koi','删除角色','2019-07-06 11:14:26','操作成功',NULL),(32,'koi','导出角色','2019-07-06 11:14:33','操作成功',NULL),(33,'koi','添加角色','2019-07-06 11:15:54','操作成功',NULL),(34,'koi','删除角色','2019-07-06 11:27:32','操作成功',NULL),(35,'koi','添加角色','2019-07-06 14:35:08','操作成功',NULL),(36,'koi','资料修改','2019-07-06 15:20:00','操作成功',NULL),(37,'koi','资料修改','2019-07-06 15:21:01','操作失败',NULL),(38,'koi','资料修改','2019-07-06 15:22:20','操作失败',NULL),(39,'koi','资料修改','2019-07-06 15:22:29','操作失败',NULL),(40,'koi','资料修改','2019-07-06 15:44:27','操作失败',NULL),(41,'koi','修改密码','2019-07-06 15:50:08','操作失败',NULL),(42,'koi','修改密码','2019-07-06 15:50:54','操作失败',NULL),(43,'koi','修改密码','2019-07-06 15:53:09','操作失败',NULL),(44,'koi','修改密码','2019-07-06 15:55:41','操作成功',NULL),(45,'koi','修改密码','2019-07-06 15:59:26','操作失败',NULL),(46,'koi','修改密码','2019-07-06 15:59:55','操作失败',NULL),(47,'koi','修改密码','2019-07-06 16:00:30','操作失败',NULL),(48,'koi','修改密码','2019-07-06 16:03:04','操作失败',NULL),(49,'koi','修改密码','2019-07-06 16:03:38','操作失败',NULL),(50,'koi','修改密码','2019-07-06 16:09:42','操作失败',NULL),(51,'koi','修改密码','2019-07-06 16:16:26','操作成功',NULL),(52,'koi','修改密码','2019-07-06 16:16:47','操作失败',NULL),(53,'koi','修改密码','2019-07-06 16:17:02','操作失败',NULL),(54,'koi','修改密码','2019-07-06 16:17:49','操作失败',NULL),(55,'koi','修改密码','2019-07-06 16:19:56','操作失败',NULL),(56,'koi','修改密码','2019-07-06 16:21:29','操作失败',NULL),(57,'koi','修改密码','2019-07-06 16:29:40','操作失败',NULL),(58,'koi','修改密码','2019-07-06 16:30:00','操作失败',NULL),(59,'koi','修改密码','2019-07-06 16:30:20','操作失败',NULL),(60,'koi','修改密码','2019-07-06 16:30:39','操作失败',NULL),(61,'koi','修改密码','2019-07-06 16:31:33','操作失败',NULL),(62,'koi','修改密码','2019-07-06 16:32:40','操作失败',NULL),(63,'koi','修改密码','2019-07-06 16:34:13','操作失败',NULL),(64,'koi','资料修改','2019-07-06 16:46:21','操作失败',NULL),(65,'koi','资料修改','2019-07-06 16:46:53','操作失败',NULL),(66,'koi','资料修改','2019-07-06 16:47:03','操作失败',NULL),(67,'koi','资料修改','2019-07-06 16:47:49','操作失败',NULL),(68,'koi','资料修改','2019-07-06 16:50:05','操作成功',NULL),(69,'koi','修改密码','2019-07-06 16:52:08','操作成功',NULL),(70,'koi','资料修改','2019-07-06 16:52:58','操作成功',NULL),(71,'koi','资料修改','2019-07-06 16:58:41','操作失败',NULL),(72,'koi','资料修改','2019-07-06 16:59:14','操作失败',NULL),(73,'koi','资料修改','2019-07-06 16:59:45','操作失败',NULL),(74,'koi','添加角色','2019-07-06 19:59:23','操作失败',NULL),(75,'koi','添加角色','2019-07-06 20:00:07','操作失败',NULL),(76,'koi','添加角色','2019-07-06 20:00:57','操作失败',NULL),(77,'koi','删除角色','2019-07-06 20:01:40','操作成功',NULL),(78,'koi','添加角色','2019-07-06 20:01:46','操作成功',NULL),(79,'koi','删除角色','2019-07-06 20:01:49','操作成功',NULL),(80,'koi','添加角色','2019-07-07 20:16:03','操作成功',NULL),(81,'koi','删除角色','2019-07-07 20:16:14','操作成功',NULL),(82,'koi','导出角色','2019-07-07 20:16:21','操作成功',NULL),(83,'koi','导出角色','2019-07-07 20:17:17','操作成功',NULL),(84,'koi','添加角色','2019-07-07 20:17:28','操作成功',NULL),(85,'koi','添加权限','2019-07-08 14:46:41','操作成功',NULL),(86,'koi','删除权限','2019-07-08 14:46:47','操作成功',NULL),(87,'koi','添加权限','2019-07-08 14:46:56','操作成功',NULL),(88,'koi','添加权限','2019-07-08 14:46:59','操作成功',NULL),(89,'koi','删除权限','2019-07-08 14:47:07','操作成功',NULL),(90,'koi','删除用户信息','2019-07-08 15:48:37','操作成功',NULL),(91,'koi','删除用户信息','2019-07-08 15:52:42','操作成功',NULL),(92,'koi','角色分配保存','2019-07-08 15:53:36','操作成功',NULL),(93,'koi','删除角色','2019-07-08 15:53:43','操作成功',NULL),(94,'koi','权限分配保存','2019-07-10 08:54:09','操作成功',NULL),(95,'koi','权限分配保存','2019-07-10 08:55:20','操作成功',NULL),(96,'koi','权限分配保存','2019-07-10 08:55:32','操作成功',NULL),(97,'koi','添加角色','2019-07-10 20:45:16','操作成功','127.0.0.1'),(98,'koi','添加角色','2019-07-15 21:06:24','操作成功','127.0.0.1'),(99,'koi','添加角色','2019-07-15 21:06:52','操作成功','127.0.0.1'),(100,'koi','添加角色','2019-07-15 21:10:12','操作成功','127.0.0.1'),(101,'koi','添加角色','2019-07-15 21:14:58','操作成功','127.0.0.1'),(102,'koi','添加角色','2019-07-15 21:15:21','操作成功','127.0.0.1'),(103,'koi','添加角色','2019-07-15 21:15:51','操作成功','127.0.0.1'),(104,'koi','添加角色','2019-07-16 08:10:26','操作失败','127.0.0.1'),(105,'koi','添加角色','2019-07-16 08:11:52','操作失败','127.0.0.1'),(106,'koi','添加角色','2019-07-16 08:13:14','操作失败','127.0.0.1'),(107,'koi','添加角色','2019-07-16 08:14:46','操作失败','127.0.0.1'),(108,'koi','添加角色','2019-07-16 08:15:51','操作失败','127.0.0.1'),(109,'koi','添加角色','2019-07-16 08:19:04','操作失败','127.0.0.1'),(110,'koi','添加角色','2019-07-16 08:41:21','操作成功','127.0.0.1'),(111,'koi','添加角色','2019-07-16 08:42:36','操作成功','127.0.0.1'),(112,'koi','删除角色','2019-07-16 08:45:18','操作成功','127.0.0.1'),(113,'koi','删除角色','2019-07-16 08:45:25','操作成功','127.0.0.1'),(114,'koi','添加权限','2019-07-16 09:20:39','操作成功','127.0.0.1'),(115,'koi','添加权限','2019-07-16 09:20:44','操作成功','127.0.0.1'),(116,'koi','添加权限','2019-07-16 09:20:49','操作成功','127.0.0.1'),(117,'koi','添加权限','2019-07-16 09:20:54','操作成功','127.0.0.1'),(118,'koi','删除权限','2019-07-16 09:21:33','操作成功','127.0.0.1'),(119,'koi','添加权限','2019-07-16 09:22:09','操作成功','127.0.0.1'),(120,'koi','添加权限','2019-07-16 09:22:13','操作成功','127.0.0.1'),(121,'koi','添加权限','2019-07-16 09:22:17','操作成功','127.0.0.1'),(122,'koi','添加权限','2019-07-16 09:22:22','操作成功','127.0.0.1');

/*Table structure for table `u_permission` */

DROP TABLE IF EXISTS `u_permission`;

CREATE TABLE `u_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) DEFAULT NULL COMMENT 'url地址',
  `name` varchar(64) DEFAULT NULL COMMENT 'url描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `u_permission` */

insert  into `u_permission`(`id`,`url`,`name`) values (1,'rolelist:view','角色列表'),(2,'rolelist:add','角色列表添加'),(3,'rolelist:delete','角色列表删除'),(4,'roleallocation:add','角色分配添加'),(5,'roleallocation:clear','角色分配清空'),(6,'permissionlist:view','权限列表'),(7,'permissionlist:add','权限列表添加'),(8,'permissionlist:delete','权限列表删除'),(9,'permissionallocation:view','权限分配'),(10,'permissionallocation:save','权限分配保存'),(11,'user:view','用户列表'),(12,'user:delete','用户列表删除'),(13,'user:forbid','用户列表激活&禁止'),(16,'rolelist:import','角色列表导入'),(17,'rolelist:export','角色列表导出'),(18,'roleallocation:view','角色分配'),(26,'ss','sss'),(27,'ss','ss'),(28,'sss','sss'),(29,'ss','sss');

/*Table structure for table `u_role` */

DROP TABLE IF EXISTS `u_role`;

CREATE TABLE `u_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `type` varchar(10) DEFAULT NULL COMMENT '角色类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `u_role` */

insert  into `u_role`(`id`,`name`,`type`) values (1,'系统管理员','100001'),(34,'用户管理','100002'),(35,'权限管理','100003');

/*Table structure for table `u_role_permission` */

DROP TABLE IF EXISTS `u_role_permission`;

CREATE TABLE `u_role_permission` (
  `rid` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '权限ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `u_role_permission` */

insert  into `u_role_permission`(`rid`,`pid`) values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(35,1),(35,2),(35,3),(35,4),(35,5),(35,17),(35,18),(35,7),(35,24),(34,1),(34,2),(34,3),(34,4),(34,8),(34,9),(34,10),(34,11),(34,12),(34,13),(34,16),(34,17),(34,18),(34,5),(34,1),(34,2),(34,3),(34,4),(34,5),(34,8),(34,9),(34,10),(34,11),(34,12),(34,13),(34,16),(34,17),(34,18);

/*Table structure for table `u_user` */

DROP TABLE IF EXISTS `u_user`;

CREATE TABLE `u_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL COMMENT '用户昵称',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱|登录帐号',
  `pswd` varchar(32) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:禁止登录',
  `salt` varchar(32) DEFAULT NULL COMMENT '盐，加密密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `u_user` */

insert  into `u_user`(`id`,`nickname`,`email`,`pswd`,`create_time`,`last_login_time`,`status`,`salt`) values (1,'koi','973319261@qq.com','26b9e614910685c40900db2fb36c4eff','2019-07-02 17:10:42','2019-07-16 09:20:26',1,'d071bf8dce5e56bc462c10853e88e353'),(4,'sss','973319261@qq.com','76c832fe655fe0232eab4d5e6b04ff37','2019-07-02 17:10:42','2019-07-05 21:15:10',1,'84164753b14b293afe9d7e040e8687ab'),(13,'www','973319261@qq.com','7529189054d7ecbf76c1866b6ad3c248','2019-07-08 15:53:14',NULL,1,'dbe125a0410a8afd114d394887a34377');

/*Table structure for table `u_user_role` */

DROP TABLE IF EXISTS `u_user_role`;

CREATE TABLE `u_user_role` (
  `uid` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `rid` bigint(20) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `u_user_role` */

insert  into `u_user_role`(`uid`,`rid`) values (1,1),(1,18),(4,1),(13,35);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
