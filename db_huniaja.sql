-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Okt 2021 pada 15.56
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_huniaja`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bill`
--

CREATE TABLE `bill` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `propertyId` int(11) NOT NULL,
  `date` date NOT NULL,
  `price` double NOT NULL,
  `status` int(11) NOT NULL,
  `bookingId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bill`
--

INSERT INTO `bill` (`id`, `userId`, `propertyId`, `date`, `price`, `status`, `bookingId`) VALUES
(87, 2, 3, '2021-10-05', 800000, 1, 38);

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE `booking` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `propertyId` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `booking`
--

INSERT INTO `booking` (`id`, `userId`, `propertyId`, `date`, `status`) VALUES
(38, 2, 3, '2021-10-04', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `facility`
--

CREATE TABLE `facility` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `propertyId` int(11) NOT NULL,
  `facilityId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `facility`
--

INSERT INTO `facility` (`id`, `propertyId`, `facilityId`) VALUES
(7, 3, 1),
(8, 3, 2),
(9, 3, 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `facility_list`
--

CREATE TABLE `facility_list` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `webIcon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobileIcon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `facility_list`
--

INSERT INTO `facility_list` (`id`, `name`, `webIcon`, `mobileIcon`) VALUES
(1, 'Kasur', 'fa fa-bed', '0xe322'),
(2, 'WC', 'fa fa-bath', '57559'),
(3, 'PDAM', 'fa fa-tint', '59088'),
(4, 'TV', 'fa fa-tv', '57794'),
(5, 'Listrik', 'fa fa-lightbulb-o', '58236');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorite`
--

CREATE TABLE `favorite` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `propertyId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `favorite`
--

INSERT INTO `favorite` (`id`, `userId`, `propertyId`) VALUES
(7, 2, 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `image`
--

CREATE TABLE `image` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `propertyId` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `image`
--

INSERT INTO `image` (`id`, `propertyId`, `image`) VALUES
(9, 3, '1.jpg'),
(10, 3, '2.jpg'),
(11, 3, '3.jpg'),
(12, 3, '4.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2021_09_10_132236_add_role_to_users_table', 2),
(7, '2021_09_10_141719_add_face_to_users_table', 3),
(8, '2021_09_10_152021_create_property_table', 4),
(9, '2021_09_10_152545_create_image_table', 4),
(10, '2021_09_10_153932_create_facility_list_table', 4),
(11, '2021_09_10_154104_create_facility_table', 4),
(12, '2021_09_10_154224_create_review_table', 4),
(13, '2021_09_10_154600_add_avaliable_to_property_table', 5),
(14, '2021_09_11_030710_add_more_column_to_users_table', 6),
(15, '2021_09_11_072142_change_phone_from_users_table', 7),
(16, '2021_09_12_063459_add_balance_column_to_users_table', 8),
(29, '2021_09_12_063706_add_vrooms_to_property_table', 9),
(30, '2021_09_12_063927_create_qproperty_view', 9),
(31, '2021_09_12_074000_create_qfacility_view', 9),
(32, '2021_09_12_075523_create_qreview_view', 10),
(33, '2021_09_12_081331_create_favorite_table', 11),
(34, '2021_09_13_033133_add_owner_to_qproperty_view', 12),
(35, '2021_09_14_034256_add_date_created_to_property_table', 13),
(37, '2021_09_14_035629_support_to_filter_qproperty_table', 14),
(38, '2021_09_14_065020_change_price_from_property_table', 15),
(39, '2021_09_14_065318_add_new_price_to_qproperty_table', 16),
(40, '2021_09_14_084915_create_booking_table', 17),
(44, '2021_09_14_085432_create_bill_table', 18),
(45, '2021_09_14_091248_create_qbooking_view', 19),
(46, '2021_09_14_101754_left_join_qbooking_table', 20),
(47, '2021_09_14_101935_left_join_qproperty_table', 21),
(48, '2021_09_14_150819_create_review_index', 22),
(49, '2021_09_15_150607_create_qbill_view', 23),
(50, '2021_09_16_043748_change_bill_price_to_double', 24),
(51, '2016_06_01_000001_create_oauth_auth_codes_table', 25),
(52, '2016_06_01_000002_create_oauth_access_tokens_table', 25),
(53, '2016_06_01_000003_create_oauth_refresh_tokens_table', 25),
(54, '2016_06_01_000004_create_oauth_clients_table', 25),
(55, '2016_06_01_000005_create_oauth_personal_access_clients_table', 25),
(56, '2021_10_04_052419_add_booking_id_to_bill_table', 26);

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('057944178add6687f8d557f05b0ae9fe2e1a43d3610a3e995a408264c70ddce2400094b58267b07f', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 08:15:36', '2021-09-21 08:15:36', '2022-09-21 15:15:36'),
('078cf38fb858ad2698f57913a63473eb6990a586aa8e117d341a5d860062494416535d0de227cdef', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 09:24:32', '2021-09-21 09:24:32', '2022-09-21 16:24:32'),
('089772d78b4fe072195cff47aec94619a361246f1ed32fabb79bb4f0db4e3f6eef8aa03e7e7710c0', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:11:22', '2021-09-20 08:11:22', '2022-09-20 15:11:22'),
('09d6883ba2ce89ae2302d591f47ac74912b13d2fa6af320758cc315de59f984401c65f71007538d7', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:12:19', '2021-09-20 08:12:19', '2022-09-20 15:12:19'),
('16423880c1d5cf6795c7e4192d50e9de4c7c0cd8603f2a11b57bb223f943090280e2c9bcd1f1835c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-26 00:24:48', '2021-09-26 00:24:48', '2022-09-26 07:24:48'),
('1db33865a9f8f904f75acce47f0a4586b534a54b036db0d3835c2ab7505b8a2e8b1d335d92a1137c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 18:40:16', '2021-09-21 18:40:16', '2022-09-22 01:40:16'),
('1fc7a5c7c2af4087f3e1a87cf4523b36eccf54ee3bf4f157b3ed0c15e03375f78d3c248e509cabb0', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:01:52', '2021-09-20 08:01:52', '2022-09-20 15:01:52'),
('2199035d4e80b6403c8bbc4a757c59dbf74914bc768e1d80da9dbad26bf6ddcfd7135c8a89704682', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:08:08', '2021-09-20 08:08:08', '2022-09-20 15:08:08'),
('253cb76926aba20868010bcd2c7fc07943fb618493c643b2a6c96c65ea8ae0691a1183470a22c672', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-25 19:53:28', '2021-09-25 19:53:28', '2022-09-26 02:53:28'),
('268fcafe071ae89304e0c80f8e3365a282516c5d10fc88c97977b40e7e790bbae12b37da7a766429', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:48:32', '2021-09-20 08:48:32', '2022-09-20 15:48:32'),
('27e78cb47508f5b8fb02f342a2e53a5ac88119208d9964cae6e4a86f312ecdc26a71d9a3639846d8', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 22:47:59', '2021-09-20 22:47:59', '2022-09-21 05:47:59'),
('2ba281d894e70f2df7cb0e952e4007b777f7aa150edf013b8862feac0097415c2aeb425afb09359c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 08:31:28', '2021-09-21 08:31:28', '2022-09-21 15:31:28'),
('2e603b38b6cf1ba50ccdc5db89221c53221b83ad8c6c03f96a78cbead4dc3385ae69c655dd0dec10', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 22:58:10', '2021-09-19 22:58:10', '2022-09-20 05:58:10'),
('36a866a917b1a37cab89028c8bc6561d2cf656f4404dddb303474c8f9e2354d995f229f4a5abd43e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 22:43:54', '2021-09-20 22:43:54', '2022-09-21 05:43:54'),
('376ed864aa86cc0b91704ba97082d9bf01ced294d376982eacfac82f49e94345e7529e3a7cb6aab8', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-29 00:46:59', '2021-09-29 00:46:59', '2022-09-29 07:46:59'),
('47ac69f913490a3f0020ed96d735944c63d516abf65808e73c3ade638d0b878b775a16e1a058f1e5', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 21:25:06', '2021-09-20 21:25:06', '2022-09-21 04:25:06'),
('4c5db2fdd10f69d35be4079afef5703d50954513ce07664363ce7f13e0ce4bc1c26ba7f597112435', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:08:30', '2021-09-20 08:08:30', '2022-09-20 15:08:30'),
('4f5a2cf94ef2853da6ec73532360a2dffc8bfd38fb6163be91b914c21e39f8abafa35dca15ca6819', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:11:13', '2021-09-20 08:11:13', '2022-09-20 15:11:13'),
('505cb58a4013e8eadb2d6b3b211040244290b5cc856b2d6ed1c890a53b4685fb78207143ddb4bc6e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 22:42:32', '2021-09-20 22:42:32', '2022-09-21 05:42:32'),
('56c40f566e5d55745ca6746a872d61a8701745d59b2cceeb96f6cba35537fd636cebd59cf7f56f01', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-22 20:41:31', '2021-09-22 20:41:31', '2022-09-23 03:41:31'),
('5cf1e19b0ba73cf6fabdb9707700bad84346c5cb8b4f3b0614edc69de6d8bfb2b8b91807411cc000', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 22:53:54', '2021-09-19 22:53:54', '2022-09-20 05:53:54'),
('6377567638df1dc0795d972b7129b1e988fe576323f34190df122838bcb115f7a6cfa9599f7c09e9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:13:00', '2021-09-20 08:13:00', '2022-09-20 15:13:00'),
('70bb0c5622b8aa91e809f8d967e70e146b6d8bafb7f16925b45815cbbb20a470490724214b07d781', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:11:10', '2021-09-20 08:11:10', '2022-09-20 15:11:10'),
('79cd3c97617e62bf4d341071caa7c130001346f520f68cec262af86ac83c0c4e26d301b3164c06dc', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:12:58', '2021-09-20 08:12:58', '2022-09-20 15:12:58'),
('8413faad7d80a39375151e9a3134f9f87df5b6e92bb3dcc7fa31b71142ebf953dc06d50b003fcb95', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 21:32:53', '2021-10-03 21:32:53', '2022-10-04 04:32:53'),
('84fd973def2ddcaa1693b935df7cf3fd25a9c9ddc8458dcfd08bfceb7312588f12cf79ab52f7a719', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:09:23', '2021-09-20 08:09:23', '2022-09-20 15:09:23'),
('9324d0ac29d01695f86184a5ac508b8f8d2d95bc125cc7d5019737ab40d5f181a082e5e4d3549758', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 21:41:32', '2021-10-03 21:41:32', '2022-10-04 04:41:32'),
('939969c2d050b652be5e3f567799c096a77c41859cc30779cb8d3cd10ebd60026e50d2add51137fc', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-28 20:54:51', '2021-09-28 20:54:51', '2022-09-29 03:54:51'),
('93e4974d3a36473a2dd98aedc4e1e98c7452ce61bf650c27c2a330850d23a5ad565d1fd993d0d780', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:07:59', '2021-09-20 08:07:59', '2022-09-20 15:07:59'),
('98830bad25493d9912f293662dc5f3e417a749739db08de7fef55ed4b867581c7b3cd7b5db92eba4', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-29 02:13:06', '2021-09-29 02:13:06', '2022-09-29 09:13:06'),
('b110c920719809575efe8b08d7b878b7e2f8bc7fef433032a62b2004f3390d0e3075f9a93a56427b', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:09:41', '2021-09-20 08:09:41', '2022-09-20 15:09:41'),
('bab505a44ece876370fc02f9c4c756210b1655f2d30061dc425b489ffce0317270814453b018f75c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:12:35', '2021-09-20 08:12:35', '2022-09-20 15:12:35'),
('bba6d6c46db50732eb1290ee94ead24fd411fcebc9fca35407687f17c3060c99968c72ff2bd20047', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 20:05:14', '2021-10-03 20:05:14', '2022-10-04 03:05:14'),
('c5b60764ee04d52db7091bfbde54a055177f6c0c76e647ab2e6203abb8e09087f96f1e8435e74f6e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-26 00:24:27', '2021-09-26 00:24:27', '2022-09-26 07:24:27'),
('c7cda350921e7ce6bf98c52dee24633c4630c184d4d21f16f2cfe8ce5d6c6d6fdf3d9f817111e2e1', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:45:48', '2021-09-20 08:45:48', '2022-09-20 15:45:48'),
('ce7cc11478a7ff0f79e550ee7830b5f85ffd636578faa5ecb9c23796c25834707d86de1351ae6e8b', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 07:43:00', '2021-09-19 07:43:00', '2022-09-19 14:43:00'),
('d159ab0130c1137ced7169e75bb3231bb6ae58f94623095a2815638c8ad6d26187d48c46e78cb624', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:07:55', '2021-09-20 08:07:55', '2022-09-20 15:07:55'),
('d3559a910c424266a38987316516a4c5bfe3f3ca0e15c17e6bf3fee91933ade162dfac1845bfe688', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 22:45:43', '2021-09-20 22:45:43', '2022-09-21 05:45:43'),
('d50d0693e24ab98f2fcb3612632148d1e1d64965ecc16c312aae75b2896f4f162916f4db42b068c9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 21:34:46', '2021-10-03 21:34:46', '2022-10-04 04:34:46'),
('dbe5e51ae5b45e5e676439a46dda52de11319e09ea87a955544dad9d07eb9d2c986e37f6ffd03a75', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:47:02', '2021-09-20 08:47:02', '2022-09-20 15:47:02'),
('e62e96891bcc50b16e6a78910b50213f471a10103c8d4d235df0b3233d7219dea0116802a744b9b9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:13:02', '2021-09-20 08:13:02', '2022-09-20 15:13:02'),
('e6ad6b1697f5afe00472723d73eb7e47d3b4d8d2c4dff46c9a73d8d66f5e09020236b70a87a1dac6', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:15:19', '2021-09-20 08:15:19', '2022-09-20 15:15:19'),
('ed4d1e42ea0d890748978108d885cb5790b576ad62097337ac6c056ebde94447a08a74112b1cc2fb', 7, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 22:56:21', '2021-09-19 22:56:21', '2022-09-20 05:56:21'),
('f0f753f02e8f8e53af9e0f2869732e6d0ccd2b292ade7b1354c583a9f3277933ed90e0ff29e43ceb', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 21:33:14', '2021-10-03 21:33:14', '2022-10-04 04:33:14'),
('f45b6ca28e6c9d61fb8115e33824362b56dd4f08e2f6ec4e49ae9adc247214e64e5152f7d3a19a06', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:45:21', '2021-09-20 08:45:21', '2022-09-20 15:45:21'),
('fd8d94fd159b98fca6c1ec9e8d76cf599e8f2d9878d41bce1c5d5589b41927b170e85f10d0fad09a', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 08:13:26', '2021-09-20 08:13:26', '2022-09-20 15:13:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'djQ5B5SVcCKJbfWRCKY2icFxtdoNGoqv0z6bRBRy', NULL, 'http://localhost', 1, 0, 0, '2021-09-19 07:27:37', '2021-09-19 07:27:37'),
(2, NULL, 'Laravel Password Grant Client', 'yicQdTmVCxRMB1fQDXTQIf4pPmX934ACuVV02XTc', 'users', 'http://localhost', 0, 1, 0, '2021-09-19 07:27:37', '2021-09-19 07:27:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2021-09-19 07:27:37', '2021-09-19 07:27:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `property`
--

CREATE TABLE `property` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ownerId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `avaliable` int(11) NOT NULL,
  `vrooms` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` date NOT NULL,
  `price_day` int(11) NOT NULL,
  `price_month` int(11) NOT NULL,
  `price_year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `property`
--

INSERT INTO `property` (`id`, `ownerId`, `name`, `description`, `address`, `latitude`, `longitude`, `type`, `avaliable`, `vrooms`, `date_created`, `price_day`, `price_month`, `price_year`) VALUES
(3, 7, 'Kontrakan Indah Surabaya', 'Pages that you view in this window won\'t appear in the browser history and they won\'t leave other traces, like cookies, on the computer after you close all open Guest windows.Pages that you view in this window won\'t appear in the browser history and they won\'t leave other traces, like cookies, on the computer after you close all open Guest windows.', 'Jl. Ketintang Madya', '-7.31517', '112.723', 2, 1, NULL, '2021-09-14', 800000, 3000000, 32000000),
(7, 7, 'Apartemen Jaya Abadi', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting', 'Gubeng', '-7.27285', '112.749', 1, 1, NULL, '2021-10-04', 500000, 3000000, 12000000);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `q_bill`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `q_bill` (
`id` bigint(20) unsigned
,`userId` int(11)
,`propertyId` int(11)
,`date` date
,`price` double
,`status` int(11)
,`propertyName` varchar(255)
,`userName` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `q_booking`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `q_booking` (
`id` bigint(20) unsigned
,`ownerId` int(11)
,`name` varchar(255)
,`description` longtext
,`address` varchar(255)
,`latitude` varchar(255)
,`longitude` varchar(255)
,`type` int(11)
,`avaliable` int(11)
,`vrooms` varchar(255)
,`date_created` date
,`price_day` int(11)
,`price_month` int(11)
,`price_year` int(11)
,`userId` int(11)
,`avg_rating` double(12,5)
,`date` date
,`status` int(11)
,`image` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `q_facility`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `q_facility` (
`id` bigint(20) unsigned
,`propertyId` int(11)
,`facilityId` int(11)
,`name` varchar(255)
,`webIcon` varchar(255)
,`mobileIcon` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `q_property`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `q_property` (
`id` bigint(20) unsigned
,`ownerId` int(11)
,`name` varchar(255)
,`description` longtext
,`address` varchar(255)
,`latitude` varchar(255)
,`longitude` varchar(255)
,`type` int(11)
,`avaliable` int(11)
,`vrooms` varchar(255)
,`date_created` date
,`price_day` int(11)
,`price_month` int(11)
,`price_year` int(11)
,`avg_rating` double(12,5)
,`count_facility` bigint(21)
,`image` varchar(255)
,`ownerName` varchar(255)
,`email` varchar(255)
,`phone` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `q_review`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `q_review` (
`id` bigint(20) unsigned
,`userId` int(11)
,`propertyId` int(11)
,`review` longtext
,`rating` double(8,1)
,`date` date
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `review`
--

CREATE TABLE `review` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `propertyId` int(11) NOT NULL,
  `review` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` double(8,1) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `review`
--

INSERT INTO `review` (`id`, `userId`, `propertyId`, `review`, `rating`, `date`) VALUES
(5, 2, 3, 'Asik', 5.0, '2021-09-15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
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
  `balance` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role`, `face`, `dob`, `address`, `phone`, `balance`) VALUES
(2, 'Qolbu Dzikru', 'qolbu.dzikru12@gmail.com', '2021-09-10 07:41:42', '$2y$10$FDshDN7zeqmD4JtwTqsB6egtFtQYnV5i6oJ6L5JK0ZxZoHdv5c2zu', NULL, '2021-09-10 07:41:42', '2021-09-10 07:41:42', 0, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACWCAYAAABkW7XSAAAAAXNSR0IArs4c6QAABGJJREFUeF7t1AEJAAAMAsHZv/RyPNwSyDncOQIECEQEFskpJgECBM5geQICBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAgQdWMQCX4yW9owAAAABJRU5ErkJggg==', '2001-12-30', '25 Conch St. Missisipi. USA 63446', '085732596470', 405133334),
(7, 'Frank Lampard', 'frank@gmail.com', '2021-09-11 00:29:32', '$2y$10$YjYZJvd0lZZhcvMjjRjhjOR6U8qcAUcNmObk8Z9icoKHKNgWMOupa', NULL, '2021-09-11 00:29:32', '2021-09-11 00:29:32', 1, NULL, NULL, NULL, '085732596470', 0);
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role`, `face`, `dob`, `address`, `phone`, `balance`) VALUES
(14, 'Abid Dzikru', 'qolbu.dzikru10@gmail.com', '2021-09-20 21:12:22', '$2y$10$9m1jeHjtXOptDzeiOWVVrOoqPKDG5d8Bg8BatsgTSxOIwbVt.dFBy', NULL, '2021-09-20 21:12:23', '2021-09-20 21:12:23', 0, 'data:image/jpeg;base64,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', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur untuk view `q_bill`
--
DROP TABLE IF EXISTS `q_bill`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_bill`  AS SELECT `bill`.`id` AS `id`, `bill`.`userId` AS `userId`, `bill`.`propertyId` AS `propertyId`, `bill`.`date` AS `date`, `bill`.`price` AS `price`, `bill`.`status` AS `status`, `property`.`name` AS `propertyName`, `users`.`name` AS `userName` FROM ((`bill` join `property` on(`bill`.`propertyId` = `property`.`id`)) join `users` on(`bill`.`userId` = `users`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_booking`
--
DROP TABLE IF EXISTS `q_booking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_booking`  AS SELECT `property`.`id` AS `id`, `property`.`ownerId` AS `ownerId`, `property`.`name` AS `name`, `property`.`description` AS `description`, `property`.`address` AS `address`, `property`.`latitude` AS `latitude`, `property`.`longitude` AS `longitude`, `property`.`type` AS `type`, `property`.`avaliable` AS `avaliable`, `property`.`vrooms` AS `vrooms`, `property`.`date_created` AS `date_created`, `property`.`price_day` AS `price_day`, `property`.`price_month` AS `price_month`, `property`.`price_year` AS `price_year`, `booking`.`userId` AS `userId`, avg(`review`.`rating`) AS `avg_rating`, `booking`.`date` AS `date`, `booking`.`status` AS `status`, `image`.`image` AS `image` FROM (((`booking` join `property` on(`property`.`id` = `booking`.`propertyId`)) join `image` on(`image`.`propertyId` = `property`.`id`)) left join `review` on(`review`.`propertyId` = `property`.`id`)) GROUP BY `property`.`id` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_facility`
--
DROP TABLE IF EXISTS `q_facility`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_facility`  AS SELECT `facility`.`id` AS `id`, `facility`.`propertyId` AS `propertyId`, `facility`.`facilityId` AS `facilityId`, `facility_list`.`name` AS `name`, `facility_list`.`webIcon` AS `webIcon`, `facility_list`.`mobileIcon` AS `mobileIcon` FROM (`facility` join `facility_list` on(`facility`.`facilityId` = `facility_list`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_property`
--
DROP TABLE IF EXISTS `q_property`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_property`  AS SELECT `property`.`id` AS `id`, `property`.`ownerId` AS `ownerId`, `property`.`name` AS `name`, `property`.`description` AS `description`, `property`.`address` AS `address`, `property`.`latitude` AS `latitude`, `property`.`longitude` AS `longitude`, `property`.`type` AS `type`, `property`.`avaliable` AS `avaliable`, `property`.`vrooms` AS `vrooms`, `property`.`date_created` AS `date_created`, `property`.`price_day` AS `price_day`, `property`.`price_month` AS `price_month`, `property`.`price_year` AS `price_year`, avg(`review`.`rating`) AS `avg_rating`, count(`facility`.`id`) AS `count_facility`, `image`.`image` AS `image`, `users`.`name` AS `ownerName`, `users`.`email` AS `email`, `users`.`phone` AS `phone` FROM ((((`property` left join `review` on(`review`.`propertyId` = `property`.`id`)) join `facility` on(`facility`.`propertyId` = `property`.`id`)) join `image` on(`image`.`propertyId` = `property`.`id`)) join `users` on(`users`.`id` = `property`.`ownerId`)) GROUP BY `property`.`id` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_review`
--
DROP TABLE IF EXISTS `q_review`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_review`  AS SELECT `review`.`id` AS `id`, `review`.`userId` AS `userId`, `review`.`propertyId` AS `propertyId`, `review`.`review` AS `review`, `review`.`rating` AS `rating`, `review`.`date` AS `date`, `users`.`name` AS `name` FROM (`review` join `users` on(`review`.`userId` = `users`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `facility`
--
ALTER TABLE `facility`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `facility_list`
--
ALTER TABLE `facility_list`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indeks untuk tabel `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indeks untuk tabel `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indeks untuk tabel `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `review_userid_propertyid_unique` (`userId`,`propertyId`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bill`
--
ALTER TABLE `bill`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT untuk tabel `booking`
--
ALTER TABLE `booking`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT untuk tabel `facility`
--
ALTER TABLE `facility`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `facility_list`
--
ALTER TABLE `facility_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `image`
--
ALTER TABLE `image`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT untuk tabel `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `property`
--
ALTER TABLE `property`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `review`
--
ALTER TABLE `review`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
