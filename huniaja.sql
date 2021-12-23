-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Des 2021 pada 21.37
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

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE `booking` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `propertyId` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 1),
(2, 1, 2),
(3, 1, 5),
(4, 1, 7),
(5, 1, 3),
(6, 1, 4),
(7, 2, 2),
(8, 2, 1),
(9, 2, 7),
(10, 2, 5);

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
(5, 'Listrik', 'fa fa-lightbulb-o', '58236'),
(7, 'Sarapan', 'fa fa-cutlery', '0xe3a0');

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
(1, 1, '46017.jpg'),
(2, 1, '80832.jpg'),
(3, 1, '25089.jpg'),
(4, 1, '33711.jpg'),
(5, 2, '29015.jpg'),
(6, 2, '74591.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `orderId` varchar(50) NOT NULL,
  `transactionId` varchar(50) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT NULL,
  `settlement_time` varchar(50) DEFAULT NULL,
  `snapToken` float NOT NULL DEFAULT 0,
  `snapUrl` varchar(150) NOT NULL,
  `transactionStatus` varchar(50) DEFAULT NULL,
  `fraudStatus` varchar(50) DEFAULT NULL,
  `amount` bigint(20) NOT NULL,
  `status` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
('02511a593be7457acad267b3fdfa9696d35aee50cd2228dd244c736897fb7ba29abb2a04b40c3e1f', 20, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 11:46:08', '2021-10-15 11:46:08', '2022-10-15 18:46:08'),
('057944178add6687f8d557f05b0ae9fe2e1a43d3610a3e995a408264c70ddce2400094b58267b07f', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 01:15:36', '2021-09-21 01:15:36', '2022-09-21 15:15:36'),
('078cf38fb858ad2698f57913a63473eb6990a586aa8e117d341a5d860062494416535d0de227cdef', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 02:24:32', '2021-09-21 02:24:32', '2022-09-21 16:24:32'),
('089772d78b4fe072195cff47aec94619a361246f1ed32fabb79bb4f0db4e3f6eef8aa03e7e7710c0', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:11:22', '2021-09-20 01:11:22', '2022-09-20 15:11:22'),
('09d6883ba2ce89ae2302d591f47ac74912b13d2fa6af320758cc315de59f984401c65f71007538d7', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:12:19', '2021-09-20 01:12:19', '2022-09-20 15:12:19'),
('0d8af510d5cffd2ace7ac58e319017b240fea61a149387c28c2e762bbbbfc44357382a0261ba73e1', 44, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 11:44:59', '2021-12-23 11:44:59', '2022-12-23 18:44:59'),
('16423880c1d5cf6795c7e4192d50e9de4c7c0cd8603f2a11b57bb223f943090280e2c9bcd1f1835c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-25 17:24:48', '2021-09-25 17:24:48', '2022-09-26 07:24:48'),
('192d527327ce241e263ce0c35b614995297e8aa27bff6a0e624b11d9fd427b47306f6a740b3dd1c4', 20, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 11:43:54', '2021-10-15 11:43:54', '2022-10-15 18:43:54'),
('1db33865a9f8f904f75acce47f0a4586b534a54b036db0d3835c2ab7505b8a2e8b1d335d92a1137c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 11:40:16', '2021-09-21 11:40:16', '2022-09-22 01:40:16'),
('1fc7a5c7c2af4087f3e1a87cf4523b36eccf54ee3bf4f157b3ed0c15e03375f78d3c248e509cabb0', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:01:52', '2021-09-20 01:01:52', '2022-09-20 15:01:52'),
('2199035d4e80b6403c8bbc4a757c59dbf74914bc768e1d80da9dbad26bf6ddcfd7135c8a89704682', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:08:08', '2021-09-20 01:08:08', '2022-09-20 15:08:08'),
('253cb76926aba20868010bcd2c7fc07943fb618493c643b2a6c96c65ea8ae0691a1183470a22c672', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-25 12:53:28', '2021-09-25 12:53:28', '2022-09-26 02:53:28'),
('268fcafe071ae89304e0c80f8e3365a282516c5d10fc88c97977b40e7e790bbae12b37da7a766429', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:48:32', '2021-09-20 01:48:32', '2022-09-20 15:48:32'),
('27e78cb47508f5b8fb02f342a2e53a5ac88119208d9964cae6e4a86f312ecdc26a71d9a3639846d8', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 15:47:59', '2021-09-20 15:47:59', '2022-09-21 05:47:59'),
('2a24b5f5307649db68067aa0299c685f57d8efbf7f1e765870e40737b6607e09d8ff8c0e9fad5696', 44, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 12:19:08', '2021-12-23 12:19:08', '2022-12-23 19:19:08'),
('2b5acd026c177b202a5d0ba80116af6753c4969f61624ce2e235dd7ceaa9607e99ac301e09fd0302', 18, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 11:46:49', '2021-10-15 11:46:49', '2022-10-15 18:46:49'),
('2ba281d894e70f2df7cb0e952e4007b777f7aa150edf013b8862feac0097415c2aeb425afb09359c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-21 01:31:28', '2021-09-21 01:31:28', '2022-09-21 15:31:28'),
('2e603b38b6cf1ba50ccdc5db89221c53221b83ad8c6c03f96a78cbead4dc3385ae69c655dd0dec10', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 15:58:10', '2021-09-19 15:58:10', '2022-09-20 05:58:10'),
('36a866a917b1a37cab89028c8bc6561d2cf656f4404dddb303474c8f9e2354d995f229f4a5abd43e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 15:43:54', '2021-09-20 15:43:54', '2022-09-21 05:43:54'),
('376ed864aa86cc0b91704ba97082d9bf01ced294d376982eacfac82f49e94345e7529e3a7cb6aab8', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-28 17:46:59', '2021-09-28 17:46:59', '2022-09-29 07:46:59'),
('47ac69f913490a3f0020ed96d735944c63d516abf65808e73c3ade638d0b878b775a16e1a058f1e5', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 14:25:06', '2021-09-20 14:25:06', '2022-09-21 04:25:06'),
('4c5db2fdd10f69d35be4079afef5703d50954513ce07664363ce7f13e0ce4bc1c26ba7f597112435', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:08:30', '2021-09-20 01:08:30', '2022-09-20 15:08:30'),
('4f5a2cf94ef2853da6ec73532360a2dffc8bfd38fb6163be91b914c21e39f8abafa35dca15ca6819', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:11:13', '2021-09-20 01:11:13', '2022-09-20 15:11:13'),
('505cb58a4013e8eadb2d6b3b211040244290b5cc856b2d6ed1c890a53b4685fb78207143ddb4bc6e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 15:42:32', '2021-09-20 15:42:32', '2022-09-21 05:42:32'),
('56c40f566e5d55745ca6746a872d61a8701745d59b2cceeb96f6cba35537fd636cebd59cf7f56f01', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-22 13:41:31', '2021-09-22 13:41:31', '2022-09-23 03:41:31'),
('5cf1e19b0ba73cf6fabdb9707700bad84346c5cb8b4f3b0614edc69de6d8bfb2b8b91807411cc000', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 15:53:54', '2021-09-19 15:53:54', '2022-09-20 05:53:54'),
('6377567638df1dc0795d972b7129b1e988fe576323f34190df122838bcb115f7a6cfa9599f7c09e9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:13:00', '2021-09-20 01:13:00', '2022-09-20 15:13:00'),
('70bb0c5622b8aa91e809f8d967e70e146b6d8bafb7f16925b45815cbbb20a470490724214b07d781', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:11:10', '2021-09-20 01:11:10', '2022-09-20 15:11:10'),
('79cd3c97617e62bf4d341071caa7c130001346f520f68cec262af86ac83c0c4e26d301b3164c06dc', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:12:58', '2021-09-20 01:12:58', '2022-09-20 15:12:58'),
('8413faad7d80a39375151e9a3134f9f87df5b6e92bb3dcc7fa31b71142ebf953dc06d50b003fcb95', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 14:32:53', '2021-10-03 14:32:53', '2022-10-04 04:32:53'),
('84fd973def2ddcaa1693b935df7cf3fd25a9c9ddc8458dcfd08bfceb7312588f12cf79ab52f7a719', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:09:23', '2021-09-20 01:09:23', '2022-09-20 15:09:23'),
('92a7f37017c06326de8b48e8ae96ff8eaf5190dc4e17466885cb173e0c8d042c21e3ab8178d7c62f', 43, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 11:02:36', '2021-12-23 11:02:36', '2022-12-23 18:02:36'),
('9324d0ac29d01695f86184a5ac508b8f8d2d95bc125cc7d5019737ab40d5f181a082e5e4d3549758', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 14:41:32', '2021-10-03 14:41:32', '2022-10-04 04:41:32'),
('939969c2d050b652be5e3f567799c096a77c41859cc30779cb8d3cd10ebd60026e50d2add51137fc', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-28 13:54:51', '2021-09-28 13:54:51', '2022-09-29 03:54:51'),
('93e4974d3a36473a2dd98aedc4e1e98c7452ce61bf650c27c2a330850d23a5ad565d1fd993d0d780', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:07:59', '2021-09-20 01:07:59', '2022-09-20 15:07:59'),
('98830bad25493d9912f293662dc5f3e417a749739db08de7fef55ed4b867581c7b3cd7b5db92eba4', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-28 19:13:06', '2021-09-28 19:13:06', '2022-09-29 09:13:06'),
('9a239ae009db55d1054d37ea5c32a44e7581388899a12b39d42f2975a4c6b28a404d12beac2296a1', 46, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 11:41:09', '2021-12-23 11:41:09', '2022-12-23 18:41:09'),
('b110c920719809575efe8b08d7b878b7e2f8bc7fef433032a62b2004f3390d0e3075f9a93a56427b', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:09:41', '2021-09-20 01:09:41', '2022-09-20 15:09:41'),
('b6601d4afff9ab30c583f2bf37b0a16d95437561e2b613fa190ebdf3ad4f360fd03c5aa814dd0114', 43, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 12:13:03', '2021-12-23 12:13:03', '2022-12-23 19:13:03'),
('b66ef470f944412f746f827e11b25ea14bb550fd5fc112ad41688e38a8d5a43563898bfba5515c30', 20, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 00:46:17', '2021-10-15 00:46:17', '2022-10-15 07:46:17'),
('bab505a44ece876370fc02f9c4c756210b1655f2d30061dc425b489ffce0317270814453b018f75c', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:12:35', '2021-09-20 01:12:35', '2022-09-20 15:12:35'),
('bba6d6c46db50732eb1290ee94ead24fd411fcebc9fca35407687f17c3060c99968c72ff2bd20047', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 13:05:14', '2021-10-03 13:05:14', '2022-10-04 03:05:14'),
('bc38f6d86861b16a2519317bc1cf8e9ec730705b6899996dbf216f1adb337c498973c08160aef8f6', 18, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 00:49:38', '2021-10-15 00:49:38', '2022-10-15 07:49:38'),
('bda8644dcb4d1983a055fd988d6c6403cd0570c6458380edcd5ef5f822e18b8c5d143b2f7137db4c', 44, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 11:13:09', '2021-12-23 11:13:09', '2022-12-23 18:13:09'),
('c5b60764ee04d52db7091bfbde54a055177f6c0c76e647ab2e6203abb8e09087f96f1e8435e74f6e', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-25 17:24:27', '2021-09-25 17:24:27', '2022-09-26 07:24:27'),
('c7cda350921e7ce6bf98c52dee24633c4630c184d4d21f16f2cfe8ce5d6c6d6fdf3d9f817111e2e1', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:45:48', '2021-09-20 01:45:48', '2022-09-20 15:45:48'),
('ce7cc11478a7ff0f79e550ee7830b5f85ffd636578faa5ecb9c23796c25834707d86de1351ae6e8b', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 00:43:00', '2021-09-19 00:43:00', '2022-09-19 14:43:00'),
('d159ab0130c1137ced7169e75bb3231bb6ae58f94623095a2815638c8ad6d26187d48c46e78cb624', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:07:55', '2021-09-20 01:07:55', '2022-09-20 15:07:55'),
('d3559a910c424266a38987316516a4c5bfe3f3ca0e15c17e6bf3fee91933ade162dfac1845bfe688', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 15:45:43', '2021-09-20 15:45:43', '2022-09-21 05:45:43'),
('d50d0693e24ab98f2fcb3612632148d1e1d64965ecc16c312aae75b2896f4f162916f4db42b068c9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 14:34:46', '2021-10-03 14:34:46', '2022-10-04 04:34:46'),
('dbe5e51ae5b45e5e676439a46dda52de11319e09ea87a955544dad9d07eb9d2c986e37f6ffd03a75', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:47:02', '2021-09-20 01:47:02', '2022-09-20 15:47:02'),
('e62e96891bcc50b16e6a78910b50213f471a10103c8d4d235df0b3233d7219dea0116802a744b9b9', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:13:02', '2021-09-20 01:13:02', '2022-09-20 15:13:02'),
('e6ad6b1697f5afe00472723d73eb7e47d3b4d8d2c4dff46c9a73d8d66f5e09020236b70a87a1dac6', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:15:19', '2021-09-20 01:15:19', '2022-09-20 15:15:19'),
('e8bd7918a58d1ef6af5b80d68c03d6c178aef279eafb50e29bcbb509b9fa70c9f067966ba3a00c53', 20, 1, 'LaravelAuthApp', '[]', 0, '2021-10-15 00:46:10', '2021-10-15 00:46:10', '2022-10-15 07:46:10'),
('ed4d1e42ea0d890748978108d885cb5790b576ad62097337ac6c056ebde94447a08a74112b1cc2fb', 7, 1, 'LaravelAuthApp', '[]', 0, '2021-09-19 15:56:21', '2021-09-19 15:56:21', '2022-09-20 05:56:21'),
('edee6b862e17535d805d722372ccc72578871611b31f046b0e9e88e87b2334c3ffea1575643c540e', 44, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 13:23:41', '2021-12-23 13:23:41', '2022-12-23 20:23:41'),
('f0f753f02e8f8e53af9e0f2869732e6d0ccd2b292ade7b1354c583a9f3277933ed90e0ff29e43ceb', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-10-03 14:33:14', '2021-10-03 14:33:14', '2022-10-04 04:33:14'),
('f2d40991b5163eb824142ee5f1a200ed05e6d2785bad40d2393c63bf927a4da80ce4dca21c9f2a7e', 43, 1, 'LaravelAuthApp', '[]', 0, '2021-12-23 11:02:22', '2021-12-23 11:02:22', '2022-12-23 18:02:22'),
('f45b6ca28e6c9d61fb8115e33824362b56dd4f08e2f6ec4e49ae9adc247214e64e5152f7d3a19a06', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:45:21', '2021-09-20 01:45:21', '2022-09-20 15:45:21'),
('fd8d94fd159b98fca6c1ec9e8d76cf599e8f2d9878d41bce1c5d5589b41927b170e85f10d0fad09a', 2, 1, 'LaravelAuthApp', '[]', 0, '2021-09-20 01:13:26', '2021-09-20 01:13:26', '2022-09-20 15:13:26');

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
(1, NULL, 'Laravel Personal Access Client', 'djQ5B5SVcCKJbfWRCKY2icFxtdoNGoqv0z6bRBRy', NULL, 'http://localhost', 1, 0, 0, '2021-09-19 00:27:37', '2021-09-19 00:27:37'),
(2, NULL, 'Laravel Password Grant Client', 'yicQdTmVCxRMB1fQDXTQIf4pPmX934ACuVV02XTc', 'users', 'http://localhost', 0, 1, 0, '2021-09-19 00:27:37', '2021-09-19 00:27:37');

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
(1, 1, '2021-09-19 00:27:37', '2021-09-19 00:27:37');

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
  `total_rooms` int(11) NOT NULL,
  `date_created` date NOT NULL,
  `price_day` int(11) DEFAULT NULL,
  `price_month` int(11) DEFAULT NULL,
  `price_year` int(11) DEFAULT NULL,
  `ownership_proof` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `discount_price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `property`
--

INSERT INTO `property` (`id`, `ownerId`, `name`, `description`, `address`, `latitude`, `longitude`, `type`, `avaliable`, `vrooms`, `total_rooms`, `date_created`, `price_day`, `price_month`, `price_year`, `ownership_proof`, `discount_price`) VALUES
(1, 44, 'Apartement Indah Kapuk', 'Jika Anda mencari akomodasi di area Suranaya, maka Sentra Timur Residence patut dipertimbangkan. Selain lokasinya dekat Kantor Walikota Surabaya, apartemen ini menyediakan fasilitas Keamanan 24 Jam, Kartu Akses, CCTV Di Area Publik, Lift, Area Bermain Anak, Kolam Renang.\r\n\r\nUnit apartemen seluas 28.9 ini juga dilengkapi dengan 2 kasur dengan masing-masing ukuran Queen Bed (160x200) dan Single Bed (100x200) berbalut linen kualitas hotel berbintang, pendingin ruangan, televisi, akses Wi-Fi gratis, perlengkapan mandi, peralatan makan dan memasak. Apartemen bisa disewa secara harian, bulanan, dan tahunan. Dari unit apartemen seluas 28.9 ini, Anda bisa menikmati City View. Ruangan apartemen ini berdesain Minimalist.', 'Surabaya', '-7.96662', '112.633', 1, 1, 'https://www.klapty.com/tour/D1H0o5PFrX', 5, '2021-12-22', 200000, 1200000, 35000000, '72342.jpg', 800000),
(2, 44, 'Rumah Pavilion Gold', 'Akses transportasi Bandara Internasional Juanda bisa diakses dengan 18 menit berkendara (14.1 km); 7 menit berkendara ke Stasiun Jemursari (3.9 km); 27 menit berkendara menuju Stasiun Surabaya Gubeng dan Stasiun Pasar Turi (13.7 km); dan Gerbang Tol Waru 1 berjarak 10 menit berkendara (4.5 km).\r\nFasilitas kesehatan terdekat adalah Rumah Sakit Siloam Surabaya yang bisa dijangkau dengan 22 menit (10.8 km); 11 menit berkendara ke Rumah Sakit Islam Jemursari (3.7 km); dan Rumah Sakit Royal Surabaya berjarak 10 menit berkendara (3.1 km).\r\n\r\nInstansi pendidikan terdekat, yaitu UIN Sunan Ampel yang bisa ditempuh dengan 19 menit berkendara (6.4 km); 13 menit berkendara ke Univesitas Negeri Surabaya (UNESA) (6.7 km); dan Universitas Kristen Petra berjarak 1 menit berjalan kaki (33 m).', 'Surabaya Gubeng', '-7.96662', '112.633', 0, 1, NULL, 2, '2021-12-22', NULL, 3000000, 45000000, '41677.jpg', NULL);

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
,`bookingId` int(11)
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
,`bookingId` bigint(20) unsigned
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
,`propertyId` bigint(20) unsigned
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
,`discount_price` int(11)
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
(39, 'adminrahma', 'adminrahma@mail.com', NULL, '$2y$10$a/TfoQal2TAqdWnuAE07xutyFkrPNJ4d.Y1ghn.b.DJJmmchS75Li', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
(40, 'Rahma Irawan', 'rahmairawan@mail.com', '2021-12-11 11:42:53', '$2y$10$FwTikaBgM5w/lfc97gOg2OsumPEYsetG7dRxHX4dH./Lh4S2X1Pni', NULL, NULL, NULL, 0, NULL, NULL, 'Jl. Surabaya No.1', '08123123428', NULL),
(41, 'sri handayani', 'srihandayani@mail.com', '2021-12-11 11:42:53', '$2y$10$bOuN/bLCv1NHQfNNywiaN.OMZ5pAnX4eEnVyryy1ar65ZyUk6ul5m', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', NULL),
(42, 'Eko', 'eko@mail.com', NULL, '$2y$10$2UvSplIFEiCXYdQ0lQJxdeEzxIzS1oGUb6OuRsIZ3MIcD0QZmqomm', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
(43, 'Imam', 'imam@mail.com', '2021-12-11 11:42:53', '$2y$10$BmHcX8ddfd1QH5GbQuEE8OsCMHgDJaY4MX.vJWNguacwsSE1g9fWq', NULL, NULL, NULL, 0, NULL, '2021-12-12', 'Jl. Surabaya No.1', '08123123428', 14222222),
(44, 'bambang', 'bambang@mail.com', '2021-12-11 11:42:53', '$2y$10$eCMmoiHM8KGggxQ.FauR7ulKixTZa3qME/ZEfLudQvqKkTRxE/N9m', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', 112700000),
(45, 'Hasan', 'hasan@mail.com', NULL, '$2y$10$uYM76w14qfngaAmGl3cvJex2MzIQN10F4CeP1eWMJj/wXNCdAtv/y', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL),
(46, 'ibnu', 'ibnu@mail.com', '2021-12-11 11:42:53', '$2y$10$sjQHLn/XGD.XsokWud7mReeetQZioiIYGJ4F1W3e9v26MjEFVbtae', NULL, NULL, NULL, 0, NULL, NULL, 'Jl. Surabaya No.1', '08123123428', 1900000),
(47, 'tahar', 'tahar@mail.com', '2021-12-11 11:42:53', '$2y$10$lhBAfTD7x8i0XJRhAjENZOyJHsGQ1B.z35VqglDhKmJsUjwx2fasW', NULL, NULL, NULL, 1, NULL, NULL, 'Jl. Jakarta No.2', '08123123428', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `withdraw`
--

CREATE TABLE `withdraw` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created` date NOT NULL,
  `status_change` date DEFAULT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_bill`
--
DROP TABLE IF EXISTS `q_bill`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_bill`  AS SELECT `bill`.`id` AS `id`, `bill`.`userId` AS `userId`, `bill`.`propertyId` AS `propertyId`, `bill`.`date` AS `date`, `bill`.`price` AS `price`, `bill`.`status` AS `status`, `bill`.`bookingId` AS `bookingId`, `property`.`name` AS `propertyName`, `users`.`name` AS `userName` FROM (((`bill` join `property` on(`bill`.`propertyId` = `property`.`id`)) join `users` on(`bill`.`userId` = `users`.`id`)) join `booking` on(`bill`.`bookingId` = `booking`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `q_booking`
--
DROP TABLE IF EXISTS `q_booking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_booking`  AS SELECT `property`.`id` AS `id`, `property`.`ownerId` AS `ownerId`, `property`.`name` AS `name`, `property`.`description` AS `description`, `property`.`address` AS `address`, `property`.`latitude` AS `latitude`, `property`.`longitude` AS `longitude`, `property`.`type` AS `type`, `property`.`avaliable` AS `avaliable`, `property`.`vrooms` AS `vrooms`, `property`.`date_created` AS `date_created`, `property`.`price_day` AS `price_day`, `property`.`price_month` AS `price_month`, `property`.`price_year` AS `price_year`, `booking`.`userId` AS `userId`, avg(`review`.`rating`) AS `avg_rating`, `booking`.`date` AS `date`, `booking`.`status` AS `status`, `booking`.`id` AS `bookingId`, `image`.`image` AS `image` FROM (((`booking` join `property` on(`property`.`id` = `booking`.`propertyId`)) join `image` on(`image`.`propertyId` = `property`.`id`)) left join `review` on(`review`.`propertyId` = `property`.`id`)) GROUP BY `property`.`id` ;

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_property`  AS SELECT `property`.`id` AS `id`, `property`.`ownerId` AS `ownerId`, `property`.`name` AS `name`, `property`.`id` AS `propertyId`, `property`.`description` AS `description`, `property`.`address` AS `address`, `property`.`latitude` AS `latitude`, `property`.`longitude` AS `longitude`, `property`.`type` AS `type`, `property`.`avaliable` AS `avaliable`, `property`.`vrooms` AS `vrooms`, `property`.`date_created` AS `date_created`, `property`.`price_day` AS `price_day`, `property`.`price_month` AS `price_month`, `property`.`price_year` AS `price_year`, `property`.`discount_price` AS `discount_price`, avg(`review`.`rating`) AS `avg_rating`, count(`facility`.`id`) AS `count_facility`, `image`.`image` AS `image`, `users`.`name` AS `ownerName`, `users`.`email` AS `email`, `users`.`phone` AS `phone` FROM ((((`property` left join `review` on(`review`.`propertyId` = `property`.`id`)) join `facility` on(`facility`.`propertyId` = `property`.`id`)) join `image` on(`image`.`propertyId` = `property`.`id`)) join `users` on(`users`.`id` = `property`.`ownerId`)) GROUP BY `property`.`id` ;

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
-- Indeks untuk tabel `invoice`
--
ALTER TABLE `invoice`
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
-- Indeks untuk tabel `withdraw`
--
ALTER TABLE `withdraw`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bill`
--
ALTER TABLE `bill`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `booking`
--
ALTER TABLE `booking`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `facility`
--
ALTER TABLE `facility`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `facility_list`
--
ALTER TABLE `facility_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `image`
--
ALTER TABLE `image`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `review`
--
ALTER TABLE `review`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT untuk tabel `withdraw`
--
ALTER TABLE `withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
