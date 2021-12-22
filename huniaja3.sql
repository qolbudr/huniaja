-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.11-MariaDB-1:10.5.11+maria~focal - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table db_huniaja.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` int(11) NOT NULL,
  `face` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_huniaja.users: ~9 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role`, `face`, `dob`, `address`, `phone`, `balance`) VALUES
	(39, 'adminrahma', 'adminrahma@mail.com', NULL, '$2y$10$a/TfoQal2TAqdWnuAE07xutyFkrPNJ4d.Y1ghn.b.DJJmmchS75Li', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
	(40, 'Rahma Irawan', 'rahmairawan@mail.com', '2021-12-11 18:42:53', '$2y$10$FwTikaBgM5w/lfc97gOg2OsumPEYsetG7dRxHX4dH./Lh4S2X1Pni', NULL, NULL, NULL, 0, NULL, NULL, 'Jl. Surabaya No.1', '08123123428', NULL),
	(41, 'sri handayani', 'srihandayani@mail.com', '2021-12-11 18:42:53', '$2y$10$bOuN/bLCv1NHQfNNywiaN.OMZ5pAnX4eEnVyryy1ar65ZyUk6ul5m', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', NULL),
	(42, 'Eko', 'eko@mail.com', NULL, '$2y$10$2UvSplIFEiCXYdQ0lQJxdeEzxIzS1oGUb6OuRsIZ3MIcD0QZmqomm', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
	(43, 'Imam', 'imam@mail.com', '2021-12-11 18:42:53', '$2y$10$BmHcX8ddfd1QH5GbQuEE8OsCMHgDJaY4MX.vJWNguacwsSE1g9fWq', NULL, NULL, NULL, 0, NULL, '2021-12-12', 'Jl. Surabaya No.1', '08123123428', 19222222),
	(44, 'bambang', 'bambang@mail.com', '2021-12-11 18:42:53', '$2y$10$eCMmoiHM8KGggxQ.FauR7ulKixTZa3qME/ZEfLudQvqKkTRxE/N9m', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', NULL),
	(45, 'Hasan', 'hasan@mail.com', NULL, '$2y$10$uYM76w14qfngaAmGl3cvJex2MzIQN10F4CeP1eWMJj/wXNCdAtv/y', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
	(46, 'ibnu', 'ibnu@mail.com', '2021-12-11 18:42:53', '$2y$10$sjQHLn/XGD.XsokWud7mReeetQZioiIYGJ4F1W3e9v26MjEFVbtae', NULL, NULL, NULL, 0, NULL, NULL, 'Jl. Surabaya No.1', '08123123428', 2700000),
	(47, 'tahar', 'tahar@mail.com', '2021-12-11 18:42:53', '$2y$10$lhBAfTD7x8i0XJRhAjENZOyJHsGQ1B.z35VqglDhKmJsUjwx2fasW', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
