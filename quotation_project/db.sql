-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: kenstack-project-quotation
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add quotation',7,'add_quotation'),(26,'Can change quotation',7,'change_quotation'),(27,'Can delete quotation',7,'delete_quotation'),(28,'Can view quotation',7,'view_quotation'),(29,'Can add invoice',8,'add_invoice'),(30,'Can change invoice',8,'change_invoice'),(31,'Can delete invoice',8,'delete_invoice'),(32,'Can view invoice',8,'view_invoice'),(33,'Can add invoice item',9,'add_invoiceitem'),(34,'Can change invoice item',9,'change_invoiceitem'),(35,'Can delete invoice item',9,'delete_invoiceitem'),(36,'Can view invoice item',9,'view_invoiceitem'),(37,'Can add quotation item',10,'add_quotationitem'),(38,'Can change quotation item',10,'change_quotationitem'),(39,'Can delete quotation item',10,'delete_quotationitem'),(40,'Can view quotation item',10,'view_quotationitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$bYyuNyHugqQOD8evSZ0Y1Q$tfYPqq57IlN5blKiiAEFR+aPtcEQWnDcO4KrwJUPrtA=','2026-08-11 10:37:40.913467',1,'Kenstack','','','admin@kenstack.com',1,1,'2026-08-05 05:18:34.933775');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'quotations','invoice'),(9,'quotations','invoiceitem'),(7,'quotations','quotation'),(10,'quotations','quotationitem'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-08-03 10:40:37.757638'),(2,'auth','0001_initial','2026-08-03 10:40:38.838224'),(3,'admin','0001_initial','2026-08-03 10:40:39.032890'),(4,'admin','0002_logentry_remove_auto_add','2026-08-03 10:40:39.042056'),(5,'admin','0003_logentry_add_action_flag_choices','2026-08-03 10:40:39.052127'),(6,'contenttypes','0002_remove_content_type_name','2026-08-03 10:40:39.192632'),(7,'auth','0002_alter_permission_name_max_length','2026-08-03 10:40:39.279243'),(8,'auth','0003_alter_user_email_max_length','2026-08-03 10:40:39.309355'),(9,'auth','0004_alter_user_username_opts','2026-08-03 10:40:39.318209'),(10,'auth','0005_alter_user_last_login_null','2026-08-03 10:40:39.407048'),(11,'auth','0006_require_contenttypes_0002','2026-08-03 10:40:39.411771'),(12,'auth','0007_alter_validators_add_error_messages','2026-08-03 10:40:39.423033'),(13,'auth','0008_alter_user_username_max_length','2026-08-03 10:40:39.515917'),(14,'auth','0009_alter_user_last_name_max_length','2026-08-03 10:40:39.607385'),(15,'auth','0010_alter_group_name_max_length','2026-08-03 10:40:39.631311'),(16,'auth','0011_update_proxy_permissions','2026-08-03 10:40:39.641315'),(17,'auth','0012_alter_user_first_name_max_length','2026-08-03 10:40:39.736207'),(18,'sessions','0001_initial','2026-08-03 10:40:39.787972'),(19,'quotations','0001_initial','2026-08-04 10:01:41.503800'),(20,'quotations','0002_quotation_balance_amount_quotation_created_at_and_more','2026-08-04 10:08:37.062211'),(21,'quotations','0003_invoice_account_holder_invoice_account_number_and_more','2026-08-04 11:18:30.411354'),(22,'quotations','0004_invoice_business_address_invoice_business_email_and_more','2026-08-06 06:08:07.601900'),(23,'quotations','0005_invoice_project_type_quotation_project_type_and_more','2026-08-07 09:49:19.722901'),(24,'quotations','0006_alter_invoice_invoice_date','2026-08-08 02:07:56.448585'),(25,'quotations','0007_invoice_enable_gst_quotation_enable_gst','2026-08-11 10:18:46.792166');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8m8u0p29edsz6khtaoiqa1qx668apnkk','.eJxVjEEOwiAQAP_C2RBYSmE9eu8bmoXdStXQpLQn499Nkx70OjOZtxpp38q4N1nHmdVVWXX5ZYnyU-oh-EH1vui81G2dkz4Sfdqmh4XldTvbv0GhVo5tdOiIIcTkkiGPTOJDsIhpAit9RG9i16N3mMFEkAmw69AaBCYhUJ8vvic2yA:1wrUIS:AqVIaxC7YlBbzq8EUqyZh8hkeP8z44zqnhmhRUuivmM','2026-08-19 05:36:08.994625'),('g7i6q4dj2zvfj2rmrogak6pkr9o4mvvz','.eJxVjEEOwiAQAP_C2RBYSmE9eu8bmoXdStXQpLQn499Nkx70OjOZtxpp38q4N1nHmdVVWXX5ZYnyU-oh-EH1vui81G2dkz4Sfdqmh4XldTvbv0GhVo5tdOiIIcTkkiGPTOJDsIhpAit9RG9i16N3mMFEkAmw69AaBCYhUJ8vvic2yA:1wtjrY:WRZqfkaBZ-RNAB4hKNUCZXCnW-wSctGhhZEYenTH4xo','2026-08-25 10:37:40.920596'),('iwnruw5bmon3yfstnmm2w3pait7k0zi9','.eJxVjEEOwiAQAP_C2RBYSmE9eu8bmoXdStXQpLQn499Nkx70OjOZtxpp38q4N1nHmdVVWXX5ZYnyU-oh-EH1vui81G2dkz4Sfdqmh4XldTvbv0GhVo5tdOiIIcTkkiGPTOJDsIhpAit9RG9i16N3mMFEkAmw69AaBCYhUJ8vvic2yA:1wrUIT:Npe_Oi3UCPePwtpVmJ4EbnWum1jUMMVjIF8wH-iE-oU','2026-08-19 05:36:09.807103');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotations_invoice`
--

DROP TABLE IF EXISTS `quotations_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotations_invoice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(100) NOT NULL,
  `customer` varchar(255) NOT NULL,
  `invoice_date` date DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `discount` decimal(12,2) NOT NULL,
  `tax` decimal(12,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `paid_amount` decimal(12,2) NOT NULL,
  `balance_amount` decimal(12,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `quotation_id` bigint NOT NULL,
  `account_holder` varchar(255) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `cgst` decimal(12,2) NOT NULL,
  `ifsc` varchar(100) NOT NULL,
  `note_message` longtext NOT NULL,
  `sgst` decimal(12,2) NOT NULL,
  `terms_conditions` longtext NOT NULL,
  `business_address` longtext NOT NULL,
  `business_email` varchar(254) NOT NULL,
  `business_gst` varchar(100) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `business_phone` varchar(50) NOT NULL,
  `business_website` varchar(255) NOT NULL,
  `client_address` longtext NOT NULL,
  `client_email` varchar(254) NOT NULL,
  `client_gst` varchar(100) NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `client_phone` varchar(50) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `project_location` varchar(255) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `valid_until` date DEFAULT NULL,
  `project_type` varchar(255) NOT NULL,
  `enable_gst` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice_number` (`invoice_number`),
  UNIQUE KEY `quotation_id` (`quotation_id`),
  CONSTRAINT `quotations_invoice_quotation_id_8a3e238c_fk_quotation` FOREIGN KEY (`quotation_id`) REFERENCES `quotations_quotation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotations_invoice`
--

LOCK TABLES `quotations_invoice` WRITE;
/*!40000 ALTER TABLE `quotations_invoice` DISABLE KEYS */;
INSERT INTO `quotations_invoice` VALUES (1,'KS/INV/2026-27/0036','Trayee','2026-08-04',22400.00,0.00,4032.00,26432.00,0.00,26432.00,'Unpaid','2026-08-04 10:47:02.001953','2026-08-08 02:14:38.794946',1,'KENSTACK TECHNOLOGIES PRIVATE LIMITED','1602010000000351','Karur Vysya Bank','Trichy Gundur Branch',2016.00,'KVBL0001602','',2016.00,'50% advance required to start the project.\r\nRemaining payment before final delivery.\r\nAdditional features will be charged separately.\r\nAdditional features will be charged separately\r\nAdditional features will be charged separately','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023','skalaitry@kenstacktechnologies.com','33AAMCK6128J1ZB','KENSTACK TECHNOLOGIES PRIVATE LIMITED','+91 824 867 9779','kenstacktechnologies.com','','A@glcom','','Trayee','498989898','Trayee Business Solutions Private Limited','USD','SOFTWARE QUOTATION','Trichy','ERP Software','2026-08-05','Website',1),(10,'KS/INV/2026-27/0038','Trayee','2026-08-10',18700.00,0.00,3366.00,22066.00,0.00,22066.00,'Unpaid','2026-08-10 05:32:31.107169','2026-08-10 05:32:31.107190',10,'KENSTACK TECHNOLOGIES PRIVATE LIMITED','1602010000000351','Karur Vysya Bank','Trichy Gundur Branch',1683.00,'KVBL0001602','10 % Discount for new customer',1683.00,'50% advance required to start the project.\r\nRemaining payment before final delivery.\r\nAdditional features will be charged separately.','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023','skalaitry@kenstacktechnologies.com','33AAMCK6128J1ZB','KENSTACK TECHNOLOGIES PRIVATE LIMITED','+91 824 867 9779','kenstacktechnologies.com','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023','a@g.com','---','Trayee','9488739572','Trayee Business Solutions Private Limited','INR','Software','Trichy','Tally','2026-08-17','Mobile App',1);
/*!40000 ALTER TABLE `quotations_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotations_invoiceitem`
--

DROP TABLE IF EXISTS `quotations_invoiceitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotations_invoiceitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quotations_invoiceit_invoice_id_aea8da9c_fk_quotation` (`invoice_id`),
  CONSTRAINT `quotations_invoiceit_invoice_id_aea8da9c_fk_quotation` FOREIGN KEY (`invoice_id`) REFERENCES `quotations_invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotations_invoiceitem`
--

LOCK TABLES `quotations_invoiceitem` WRITE;
/*!40000 ALTER TABLE `quotations_invoiceitem` DISABLE KEYS */;
INSERT INTO `quotations_invoiceitem` VALUES (73,'Website Design (UI/UX','Basic Custom responsive design with banner, menu (Home, About, Contact us), and content.',3,300.00,900.00,1),(74,'Services Pages','Minimum 5 pages. If extra per page Rs. 250 charged',1,4000.00,4000.00,1),(75,'Gallery','Photos and videos of the destinations',1,100.00,100.00,1),(76,'Admin Panel','User Authetication, add/edit/delete packages,search booking',3,3000.00,9000.00,1),(77,'Whatsapp &Email Integration','After booking details send to Whatsapp & Email Integration',4,800.00,3200.00,1),(78,'SEO Optimization','Basic on-page SEO setup (meta tags, keywords)',1,100.00,100.00,1),(79,'Mobile Responsiveness','Ensuring compatibility with all devices',4,600.00,2400.00,1),(80,'Domain Purchase Cost','Domain Purchase Cos',3,500.00,1500.00,1),(81,'Resposive','Mobile Resposive',4,300.00,1200.00,1),(110,'Website Design (UI/UX)','Basic Custom responsive design with banner, menu (Home, About, Contact us), and content',3,1000.00,3000.00,10),(111,'Services Pages','Minimum 5 pages. If extra per page Rs. 250 charged`',4,500.00,2000.00,10),(112,'Gallery','Photos and videos of the destinations',1,2000.00,2000.00,10),(113,'Admin Panel','User Authetication, add/edit/delete packages,search booking',1,5000.00,5000.00,10),(114,'Whatsapp &Email Integration','After booking details send to Whatsapp & Email Integratio',1,1000.00,1000.00,10),(115,'SEO Optimization','Basic on-page SEO setup (meta tags, keywords)',2,500.00,1000.00,10),(116,'Mobile Responsiveness','Ensuring compatibility with all devices',1,1000.00,1000.00,10),(117,'Domain Purchase Cost','Domain Purchase Cost',1,700.00,700.00,10),(118,'Resposive','Mobile Resposive',1,3000.00,3000.00,10);
/*!40000 ALTER TABLE `quotations_invoiceitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotations_quotation`
--

DROP TABLE IF EXISTS `quotations_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotations_quotation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `quotation_no` varchar(100) NOT NULL,
  `issued_date` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `project_location` varchar(255) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `business_email` varchar(254) NOT NULL,
  `business_phone` varchar(50) NOT NULL,
  `business_gst` varchar(100) NOT NULL,
  `business_website` varchar(255) NOT NULL,
  `business_address` longtext NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `client_email` varchar(254) NOT NULL,
  `client_phone` varchar(50) NOT NULL,
  `client_gst` varchar(100) NOT NULL,
  `client_address` longtext NOT NULL,
  `balance_amount` decimal(12,2) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `discount` decimal(12,2) NOT NULL,
  `paid_amount` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `tax` decimal(12,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `account_holder` varchar(255) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `cgst` decimal(12,2) NOT NULL,
  `ifsc` varchar(100) NOT NULL,
  `note_message` longtext NOT NULL,
  `sgst` decimal(12,2) NOT NULL,
  `terms_conditions` longtext NOT NULL,
  `project_type` varchar(255) NOT NULL,
  `enable_gst` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quotation_no` (`quotation_no`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotations_quotation`
--

LOCK TABLES `quotations_quotation` WRITE;
/*!40000 ALTER TABLE `quotations_quotation` DISABLE KEYS */;
INSERT INTO `quotations_quotation` VALUES (1,'SOFTWARE QUOTATION','KS/QUT/2026-27/0036','2026-08-04','2026-08-05','Trichy','USD','ERP Software','KENSTACK TECHNOLOGIES PRIVATE LIMITED','skalaitry@kenstacktechnologies.com','+91 824 867 9779','33AAMCK6128J1ZB','kenstacktechnologies.com','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023','Trayee','Trayee Business Solutions Private Limited','A@glcom','498989898','','',26432.00,'2026-08-04 10:46:38.249491',0.00,0.00,22400.00,4032.00,26432.00,'2026-08-06 06:10:12.346596','KENSTACK TECHNOLOGIES PRIVATE LIMITED','1602010000000351','Karur Vysya Bank','Trichy Gundur Branch',2016.00,'KVBL0001602','',2016.00,'50% advance required to start the project.\r\nRemaining payment before final delivery.\r\nAdditional features will be charged separately.\r\nAdditional features will be charged separately\r\nAdditional features will be charged separately','Website',1),(10,'Software','KS/QUT/2026-27/0038','2026-08-10','2026-08-17','Trichy','INR','Tally','KENSTACK TECHNOLOGIES PRIVATE LIMITED','skalaitry@kenstacktechnologies.com','+91 824 867 9779','33AAMCK6128J1ZB','kenstacktechnologies.com','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023','Trayee','Trayee Business Solutions Private Limited','a@g.com','9488739572','---','2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023',22066.00,'2026-08-10 05:30:42.460996',0.00,0.00,18700.00,3366.00,22066.00,'2026-08-10 05:30:42.470718','KENSTACK TECHNOLOGIES PRIVATE LIMITED','1602010000000351','Karur Vysya Bank','Trichy Gundur Branch',1683.00,'KVBL0001602','10 % Discount for new customer',1683.00,'50% advance required to start the project.\r\nRemaining payment before final delivery.\r\nAdditional features will be charged separately.','Mobile App',1);
/*!40000 ALTER TABLE `quotations_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotations_quotationitem`
--

DROP TABLE IF EXISTS `quotations_quotationitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotations_quotationitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `quotation_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quotations_quotation_quotation_id_9791bda3_fk_quotation` (`quotation_id`),
  CONSTRAINT `quotations_quotation_quotation_id_9791bda3_fk_quotation` FOREIGN KEY (`quotation_id`) REFERENCES `quotations_quotation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotations_quotationitem`
--

LOCK TABLES `quotations_quotationitem` WRITE;
/*!40000 ALTER TABLE `quotations_quotationitem` DISABLE KEYS */;
INSERT INTO `quotations_quotationitem` VALUES (81,'Website Design (UI/UX','Basic Custom responsive design with banner, menu (Home, About, Contact us), and content.',3,300.00,900.00,1),(82,'Services Pages','Minimum 5 pages. If extra per page Rs. 250 charged',1,4000.00,4000.00,1),(83,'Gallery','Photos and videos of the destinations',1,100.00,100.00,1),(84,'Admin Panel','User Authetication, add/edit/delete packages,search booking',3,3000.00,9000.00,1),(85,'Whatsapp &Email Integration','After booking details send to Whatsapp & Email Integration',4,800.00,3200.00,1),(86,'SEO Optimization','Basic on-page SEO setup (meta tags, keywords)',1,100.00,100.00,1),(87,'Mobile Responsiveness','Ensuring compatibility with all devices',4,600.00,2400.00,1),(88,'Domain Purchase Cost','Domain Purchase Cos',3,500.00,1500.00,1),(89,'Resposive','Mobile Resposive',4,300.00,1200.00,1),(128,'Website Design (UI/UX)','Basic Custom responsive design with banner, menu (Home, About, Contact us), and content',3,1000.00,3000.00,10),(129,'Services Pages','Minimum 5 pages. If extra per page Rs. 250 charged`',4,500.00,2000.00,10),(130,'Gallery','Photos and videos of the destinations',1,2000.00,2000.00,10),(131,'Admin Panel','User Authetication, add/edit/delete packages,search booking',1,5000.00,5000.00,10),(132,'Whatsapp &Email Integration','After booking details send to Whatsapp & Email Integratio',1,1000.00,1000.00,10),(133,'SEO Optimization','Basic on-page SEO setup (meta tags, keywords)',2,500.00,1000.00,10),(134,'Mobile Responsiveness','Ensuring compatibility with all devices',1,1000.00,1000.00,10),(135,'Domain Purchase Cost','Domain Purchase Cost',1,700.00,700.00,10),(136,'Resposive','Mobile Resposive',1,3000.00,3000.00,10);
/*!40000 ALTER TABLE `quotations_quotationitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-11 17:14:13
