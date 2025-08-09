-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: multitenantbanking
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `account_type` varchar(50) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT '0.00',
  `currency` varchar(10) DEFAULT 'USD',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bank_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_id` (`account_id`),
  KEY `bank_id` (`bank_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`bank_id`),
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `accounts_chk_1` CHECK ((`account_type` in (_utf8mb4'savings',_utf8mb4'checking')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'savings',4600.00,'USD','2025-01-23 16:29:43',1),(2,2,'checking',2500.00,'GBP','2025-01-23 16:29:43',2),(3,3,'savings',8000.00,'INR','2025-01-23 16:29:43',3),(4,4,'savings',78900.00,'INR','2025-05-04 09:28:03',4);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `account_update_log` AFTER UPDATE ON `accounts` FOR EACH ROW BEGIN
    INSERT INTO audit_logs (table_name, action, changed_by)
    VALUES ('accounts', 'update', CURRENT_USER());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `changed_by` varchar(100) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,'accounts','update','root@localhost','2025-01-24 08:03:59'),(2,'accounts','update','root@localhost','2025-01-24 17:49:30'),(3,'accounts','update','root@localhost','2025-01-24 17:49:30'),(4,'accounts','update','root@localhost','2025-01-24 17:49:30');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bank_customers`
--

DROP TABLE IF EXISTS `bank_customers`;
/*!50001 DROP VIEW IF EXISTS `bank_customers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bank_customers` AS SELECT 
 1 AS `customer_id`,
 1 AS `bank_id`,
 1 AS `name`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `credit_score`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `bank_id` bigint unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bank_id`),
  UNIQUE KEY `bank_id` (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` VALUES (1,'Bank of America','USA','2025-01-23 16:29:32'),(2,'HSBC','UK','2025-01-23 16:29:32'),(3,'HDFC Bank','INDIA','2025-01-23 16:29:32'),(4,'SBI Bank','INDIA','2025-01-24 14:54:55'),(5,'RBL Bank','INDIA','2025-01-24 14:54:55'),(6,'AXIS Bank','INDIA','2025-01-24 14:54:55'),(7,'KOTAK Bank','INDIA','2025-01-24 14:54:55');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_transactions`
--

DROP TABLE IF EXISTS `customer_transactions`;
/*!50001 DROP VIEW IF EXISTS `customer_transactions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_transactions` AS SELECT 
 1 AS `name`,
 1 AS `account_type`,
 1 AS `transaction_type`,
 1 AS `amount`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bank_id` bigint unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varbinary(255) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `credit_score` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id` (`customer_id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_customer_email` (`email`),
  KEY `bank_id` (`bank_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`bank_id`),
  CONSTRAINT `customers_chk_1` CHECK ((`credit_score` between 300 and 850))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,1,'Alice Johnson',_binary 'alice@email.com','1234567890',750,'2025-01-23 16:29:39'),(2,2,'Bob Smith',_binary 'bob@email.com','9876543210',680,'2025-01-23 16:29:39'),(3,3,'Charlie Brown',_binary 'charlie@email.com','5678901234',710,'2025-01-23 16:29:39'),(4,4,'John Doe',_binary 'john@example.com','1234447890',750,'2025-01-24 14:59:42'),(5,5,'Alice Smith',_binary 'alice@example.com','1234596870',680,'2025-01-24 14:59:42'),(6,6,'Robert Brown',_binary 'robert@example.com','1234789620',720,'2025-01-24 14:59:42'),(7,7,'Emily Johnson',_binary 'emily@example.com','9874567890',640,'2025-01-24 14:59:42'),(8,4,'David Miller',_binary 'david@example.com','9459684340',800,'2025-01-24 14:59:42');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fraud_logs`
--

DROP TABLE IF EXISTS `fraud_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fraud_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `flagged_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fraud_logs`
--

LOCK TABLES `fraud_logs` WRITE;
/*!40000 ALTER TABLE `fraud_logs` DISABLE KEYS */;
INSERT INTO `fraud_logs` VALUES (1,1,15000.00,'2025-01-23 16:44:44'),(2,1,15000.00,'2025-01-24 07:49:50');
/*!40000 ALTER TABLE `fraud_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `loan_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `approved_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`),
  UNIQUE KEY `loan_id` (`loan_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `loans_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
INSERT INTO `loans` VALUES (1,1,20000.00,'approved',1,'2025-01-23 16:29:51'),(2,2,15000.00,'rejected',2,'2025-01-23 16:29:51'),(3,3,5000.00,'approved',3,'2025-01-23 16:29:51');
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `monthly_transaction_summary`
--

DROP TABLE IF EXISTS `monthly_transaction_summary`;
/*!50001 DROP VIEW IF EXISTS `monthly_transaction_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `monthly_transaction_summary` AS SELECT 
 1 AS `bank_id`,
 1 AS `month`,
 1 AS `total_transactions`,
 1 AS `total_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bank_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `idx_transaction_date` (`created_at`),
  KEY `idx_account_transactions` (`account_id`,`created_at`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `transactions_chk_1` CHECK ((`transaction_type` in (_utf8mb4'deposit',_utf8mb4'withdrawal',_utf8mb4'transfer'))),
  CONSTRAINT `transactions_chk_2` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,'deposit',1000.00,'2025-01-23 16:29:47',NULL,2025),(2,2,'withdrawal',500.00,'2025-01-23 16:29:47',NULL,2025),(3,3,'transfer',3000.00,'2025-01-23 16:29:47',NULL,2025),(8,1,'transfer',15000.00,'2025-01-23 16:44:44',NULL,2025),(9,1,'transfer',15000.00,'2025-01-24 07:49:50',NULL,2025),(10,1,'deposit',500.00,'2025-01-24 07:50:03',NULL,2025);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `fraud_check` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    
    IF NEW.amount > 10000 THEN
        
        INSERT INTO fraud_logs(account_id, amount, flagged_at)
        VALUES (NEW.account_id, NEW.amount, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bank_customers`
--

/*!50001 DROP VIEW IF EXISTS `bank_customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bank_customers` AS select `customers`.`customer_id` AS `customer_id`,`customers`.`bank_id` AS `bank_id`,`customers`.`name` AS `name`,`customers`.`email` AS `email`,`customers`.`phone` AS `phone`,`customers`.`credit_score` AS `credit_score`,`customers`.`created_at` AS `created_at` from `customers` where (`customers`.`bank_id` = current_user()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_transactions`
--

/*!50001 DROP VIEW IF EXISTS `customer_transactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_transactions` AS select `c`.`name` AS `name`,`a`.`account_type` AS `account_type`,`t`.`transaction_type` AS `transaction_type`,`t`.`amount` AS `amount`,`t`.`created_at` AS `created_at` from ((`customers` `c` join `accounts` `a` on((`c`.`customer_id` = `a`.`customer_id`))) join `transactions` `t` on((`a`.`account_id` = `t`.`account_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `monthly_transaction_summary`
--

/*!50001 DROP VIEW IF EXISTS `monthly_transaction_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `monthly_transaction_summary` AS select `transactions`.`bank_id` AS `bank_id`,month(`transactions`.`created_at`) AS `month`,count(0) AS `total_transactions`,sum(`transactions`.`amount`) AS `total_amount` from `transactions` group by `transactions`.`bank_id`,month(`transactions`.`created_at`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-06  8:55:14
