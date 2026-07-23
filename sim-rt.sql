-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Jul 2026 pada 07.29
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sim-rt`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bantuan`
--

CREATE TABLE `bantuan` (
  `id_bantuan` int(11) NOT NULL,
  `id_warga` int(11) NOT NULL,
  `jenis_bantuan` varchar(100) NOT NULL,
  `tanggal_terima` date NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan`
--

CREATE TABLE `laporan` (
  `id_laporan` int(11) NOT NULL,
  `judul` varchar(150) NOT NULL,
  `jenis_laporan` varchar(50) NOT NULL,
  `periode` varchar(20) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran_iuran`
--

CREATE TABLE `pembayaran_iuran` (
  `id_iuran` int(11) NOT NULL,
  `id_warga` int(11) NOT NULL,
  `bulan` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `jumlah_bayar` decimal(15,2) NOT NULL DEFAULT 0.00,
  `tanggal_bayar` date DEFAULT NULL,
  `metode_bayar` varchar(50) DEFAULT 'Tunai',
  `status_bayar` enum('belum_bayar','lunas') DEFAULT 'belum_bayar',
  `dicatat_oleh` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaduan`
--

CREATE TABLE `pengaduan` (
  `id_pengaduan` int(11) NOT NULL,
  `id_warga` int(11) NOT NULL,
  `kategori` varchar(150) NOT NULL,
  `isi_aduan` text NOT NULL,
  `tanggal_aduan` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('baru','diproses','selesai') DEFAULT 'baru',
  `tanggapan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengajuan_surat`
--

CREATE TABLE `pengajuan_surat` (
  `id_surat` int(11) NOT NULL,
  `id_warga` int(11) NOT NULL,
  `jenis_surat` varchar(100) NOT NULL,
  `keperluan` text NOT NULL,
  `tanggal_ajuan` timestamp NOT NULL DEFAULT current_timestamp(),
  `tanggal_diproses` datetime DEFAULT NULL,
  `diproses_oleh` int(11) DEFAULT NULL,
  `status` enum('pending','disetujui','ditolak') DEFAULT 'pending',
  `nomor_surat` varchar(100) DEFAULT NULL,
  `catatan_rt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengajuan_surat`
--

INSERT INTO `pengajuan_surat` (`id_surat`, `id_warga`, `jenis_surat`, `keperluan`, `tanggal_ajuan`, `tanggal_diproses`, `diproses_oleh`, `status`, `nomor_surat`, `catatan_rt`) VALUES
(3, 69, 'Keterangan Usaha', 'PENGAJUAN SERTFIKAT HALAM UMKM', '2026-07-23 04:00:03', '2026-07-23 12:03:28', 2, 'ditolak', NULL, 'MAAF ADA TYPO SEGERA REVISI DAN KIRIM KEMBALI'),
(4, 69, 'Keterangan Usaha', 'UNTUK MENGAJUKAN SERTIFIKAT HALAL UMKM', '2026-07-23 04:04:36', '2026-07-23 12:05:27', 2, 'disetujui', '001/SKU/RT17/2026', NULL),
(5, 69, 'Pengantar KTP', 'UNTUK MEMBUAT E-KTP BARU', '2026-07-23 04:28:38', '2026-07-23 12:29:08', 1, 'disetujui', '002/SPK/RT17/2026', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaturan`
--

CREATE TABLE `pengaturan` (
  `id_setting` int(11) NOT NULL,
  `nominal_iuran` decimal(15,2) DEFAULT 10000.00,
  `nama_rt` varchar(100) DEFAULT 'Fathur Ramadhan, S.Tr.Kom., M.Kom.',
  `nama_kelurahan` varchar(100) DEFAULT 'Kelurahan Basirih Selatan',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengaturan`
--

INSERT INTO `pengaturan` (`id_setting`, `nominal_iuran`, `nama_rt`, `nama_kelurahan`, `updated_at`) VALUES
(1, 10000.00, 'Fathur Ramadhan, S.Tr.Kom., M.Kom.', 'Kelurahan Basirih Selatan', '2026-07-23 02:43:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id_pengumuman` int(11) NOT NULL,
  `penulis` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `judul` varchar(255) NOT NULL,
  `isi` text NOT NULL,
  `tanggal_post` datetime DEFAULT current_timestamp(),
  `status` enum('aktif','arsip') DEFAULT 'aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengumuman`
--

INSERT INTO `pengumuman` (`id_pengumuman`, `penulis`, `id_user`, `judul`, `isi`, `tanggal_post`, `status`, `created_at`) VALUES
(1, 1, 1, 'Selamat Datang di SIM-RT 17', 'Aplikasi Sistem Informasi Manajemen RT 17 Kelurahan Basirih Selatan telah resmi digunakan. Silakan login menggunakan akun masing-masing.', '2026-07-23 10:15:45', 'aktif', '2026-07-23 02:15:45'),
(2, 1, 1, 'Jadwal Kerja Bakti', 'Diberitahukan kepada seluruh warga RT 17 akan diadakan kerja bakti membersihkan lingkungan pada hari Minggu pagi. Mohon partisipasi semua warga.', '2026-07-23 10:15:45', '', '2026-07-23 02:15:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `profil_sosial_warga`
--

CREATE TABLE `profil_sosial_warga` (
  `id_profil` int(11) NOT NULL,
  `id_warga` int(11) NOT NULL,
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghucu') DEFAULT 'Islam',
  `status_perkawinan` enum('Belum Kawin','Kawin','Cerai Hidup','Cerai Mati') DEFAULT 'Belum Kawin',
  `status_ekonomi` enum('Mampu','Menengah','Kurang Mampu') DEFAULT 'Menengah',
  `penerima_bansos` tinyint(1) DEFAULT 0,
  `jenis_bansos` varchar(100) DEFAULT 'Tidak Menerima',
  `penerima_beasiswa` tinyint(1) DEFAULT 0,
  `jenis_beasiswa` varchar(100) DEFAULT 'Tidak Menerima',
  `terdampak_ekonomi` enum('Ya','Tidak') DEFAULT 'Tidak',
  `keterangan_tambahan` text DEFAULT NULL,
  `status_disabilitas` enum('Tidak Ada','Fisik','Netra','Rungu/Wicara','Mental','Ganda') DEFAULT 'Tidak Ada',
  `pendidikan_terakhir` varchar(50) DEFAULT NULL,
  `kewarganegaraan` varchar(50) DEFAULT 'Indonesia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `profil_sosial_warga`
--

INSERT INTO `profil_sosial_warga` (`id_profil`, `id_warga`, `agama`, `status_perkawinan`, `status_ekonomi`, `penerima_bansos`, `jenis_bansos`, `penerima_beasiswa`, `jenis_beasiswa`, `terdampak_ekonomi`, `keterangan_tambahan`, `status_disabilitas`, `pendidikan_terakhir`, `kewarganegaraan`) VALUES
(4, 4, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(5, 5, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(6, 6, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(7, 7, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(8, 8, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(9, 9, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(10, 10, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(11, 11, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(12, 12, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(13, 13, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(14, 14, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(15, 15, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(16, 16, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(17, 17, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(18, 18, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(19, 19, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(20, 20, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(21, 21, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(22, 22, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(23, 23, 'Islam', 'Belum Kawin', 'Mampu', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(24, 24, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(25, 25, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(26, 26, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(27, 27, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(28, 28, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(29, 29, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(30, 30, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(31, 31, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(32, 32, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(33, 33, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(34, 34, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(35, 35, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(36, 36, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(37, 37, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(38, 38, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(39, 39, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(40, 40, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(41, 41, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PIP (Program Indonesia Pintar)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(42, 42, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(43, 43, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(44, 44, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(45, 45, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(46, 46, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(47, 47, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(48, 48, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(49, 49, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(50, 50, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(51, 51, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(52, 52, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(53, 53, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(54, 54, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(55, 55, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(56, 56, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(57, 57, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(58, 58, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(59, 59, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(60, 60, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(61, 61, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(62, 62, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(63, 63, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(64, 64, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(65, 65, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(66, 66, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(67, 67, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(68, 68, 'Islam', 'Belum Kawin', 'Kurang Mampu', 1, 'PKH (Program Keluarga Harapan)', 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(69, 69, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(70, 70, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(71, 71, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(72, 72, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(73, 73, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(74, 74, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(75, 75, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(76, 76, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(77, 77, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(78, 78, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(79, 79, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(80, 80, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(81, 81, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(82, 82, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(83, 83, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(84, 84, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(85, 85, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(86, 86, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(87, 87, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia'),
(88, 88, 'Islam', 'Belum Kawin', 'Menengah', 0, NULL, 0, 'Tidak Menerima', 'Tidak', NULL, 'Tidak Ada', NULL, 'Indonesia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tamu`
--

CREATE TABLE `tamu` (
  `id_tamu` int(11) NOT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `nama_tamu` varchar(100) NOT NULL,
  `alamat` text DEFAULT NULL,
  `keperluan` text NOT NULL,
  `bertemu_dengan` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_kas`
--

CREATE TABLE `transaksi_kas` (
  `id_kas` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` text NOT NULL,
  `jenis` enum('masuk','keluar') NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `dicatat_oleh` int(11) DEFAULT NULL,
  `jumlah` decimal(15,2) NOT NULL,
  `metode_bayar` varchar(50) DEFAULT 'Tunai',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `id_warga` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','ketua_rt','bendahara','warga') NOT NULL,
  `status_aktif` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `id_warga`, `username`, `password`, `role`, `status_aktif`, `last_login`, `created_at`) VALUES
(1, NULL, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 1, '2026-07-23 12:28:58', '2026-07-23 02:09:56'),
(2, NULL, 'ketuart', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ketua_rt', 1, '2026-07-23 12:05:21', '2026-07-23 02:09:56'),
(3, NULL, 'bendahara', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'bendahara', 1, '2026-07-23 11:43:31', '2026-07-23 02:09:56'),
(6, 69, 'AGUSSALIM', '$2y$10$ZPI5i/eR1Y94RqzRhZLuaeopg97Zpc53VJdCkP07KJ8vUhcjWXkti', 'warga', 1, '2026-07-23 12:36:32', '2026-07-23 03:41:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `warga`
--

CREATE TABLE `warga` (
  `id_warga` int(11) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `no_kk` varchar(20) DEFAULT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `pekerjaan` varchar(50) DEFAULT NULL,
  `pendidikan_terakhir` varchar(30) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `rt` varchar(3) DEFAULT '17',
  `rw` varchar(3) DEFAULT '02',
  `status_hubungan_kk` enum('Kepala Keluarga','Istri','Suami','Anak','Cucu','Orang Tua','Mertua','Famili Lain','Pembantu','Lainnya') DEFAULT 'Kepala Keluarga',
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL DEFAULT 'Laki-laki',
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghucu') DEFAULT 'Islam',
  `status_kawin` enum('Belum Kawin','Kawin','Cerai Hidup','Cerai Mati') DEFAULT 'Belum Kawin',
  `no_hp` varchar(15) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `warga`
--

INSERT INTO `warga` (`id_warga`, `nik`, `no_kk`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `pekerjaan`, `pendidikan_terakhir`, `alamat`, `rt`, `rw`, `status_hubungan_kk`, `jenis_kelamin`, `agama`, `status_kawin`, `no_hp`, `created_at`) VALUES
(4, '6371010101001001', '6371020101001001', 'Budi Santoso', 'Banjarmasin', '1980-01-15', 'Wiraswasta', 'S1', 'Jl. Mantuil No. 1', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500001', '2026-07-23 03:21:18'),
(5, '6371020101001002', '6371020101001001', 'Siti Aminah', 'Banjarmasin', '1982-05-20', 'IRT', 'S1', 'Jl. Mantuil No. 1', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500002', '2026-07-23 03:21:18'),
(6, '6371010101002001', '6371020101002001', 'Anton Wijaya', 'Banjarmasin', '1979-03-10', 'PNS', 'S1', 'Jl. Mantuil No. 2', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Kristen', 'Kawin', '081234500003', '2026-07-23 03:21:18'),
(7, '6371020101002002', '6371020101002001', 'Dewi Lestari', 'Banjarmasin', '1981-07-22', 'Guru', 'S1', 'Jl. Mantuil No. 2', '017', '005', 'Istri', 'Perempuan', 'Kristen', 'Kawin', '081234500004', '2026-07-23 03:21:18'),
(8, '6371010101003001', '6371020101003001', 'Joko Susilo', 'Banjarmasin', '1985-08-11', 'Dokter', 'S2', 'Jl. Mantuil No. 3', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500005', '2026-07-23 03:21:18'),
(9, '6371020101003002', '6371020101003001', 'Rina Wati', 'Banjarmasin', '1987-02-14', 'Karyawan Swasta', 'S1', 'Jl. Mantuil No. 3', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500006', '2026-07-23 03:21:18'),
(10, '6371010101004001', '6371020101004001', 'Hendra Gunawan', 'Banjarmasin', '1978-12-01', 'Direktur', 'S1', 'Jl. Mantuil No. 4', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500007', '2026-07-23 03:21:18'),
(11, '6371020101004002', '6371020101004001', 'Maya Sari', 'Banjarmasin', '1980-09-25', 'IRT', 'SMA', 'Jl. Mantuil No. 4', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500008', '2026-07-23 03:21:18'),
(12, '6371010101005001', '6371020101005001', 'Rizal Hamdan', 'Banjarmasin', '1982-11-19', 'Pengusaha', 'S1', 'Jl. Mantuil No. 5', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500009', '2026-07-23 03:21:18'),
(13, '6371020101005002', '6371020101005001', 'Fitri Handayani', 'Banjarmasin', '1984-04-30', 'PNS', 'S1', 'Jl. Mantuil No. 5', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500010', '2026-07-23 03:21:18'),
(14, '6371010101006001', '6371020101006001', 'Agus Setiawan', 'Banjarmasin', '1981-06-12', 'Notaris', 'S1', 'Jl. Mantuil No. 6', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500011', '2026-07-23 03:21:18'),
(15, '6371020101006002', '6371020101006001', 'Yuni Astuti', 'Banjarmasin', '1983-01-08', 'IRT', 'S1', 'Jl. Mantuil No. 6', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500012', '2026-07-23 03:21:18'),
(16, '6371010101007001', '6371020101007001', 'Dedi Kurniawan', 'Banjarmasin', '1986-09-17', 'Arsitek', 'S1', 'Jl. Mantuil No. 7', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500013', '2026-07-23 03:21:18'),
(17, '6371020101007002', '6371020101007001', 'Nia Ramadhani', 'Banjarmasin', '1988-12-05', 'Apoteker', 'S1', 'Jl. Mantuil No. 7', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500014', '2026-07-23 03:21:18'),
(18, '6371010101008001', '6371020101008001', 'Eko Prasetyo', 'Banjarmasin', '1977-05-22', 'Manager', 'S1', 'Jl. Mantuil No. 8', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500015', '2026-07-23 03:21:18'),
(19, '6371020101008002', '6371020101008001', 'Lia Anggraini', 'Banjarmasin', '1979-08-14', 'Karyawan Swasta', 'D3', 'Jl. Mantuil No. 8', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500016', '2026-07-23 03:21:18'),
(20, '6371010101009001', '6371020101009001', 'Fajar Nugroho', 'Banjarmasin', '1984-02-28', 'Karyawan BANK', 'S1', 'Jl. Mantuil No. 9', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500017', '2026-07-23 03:21:18'),
(21, '6371020101009002', '6371020101009001', 'Sinta Dewi', 'Banjarmasin', '1986-07-19', 'IRT', 'S1', 'Jl. Mantuil No. 9', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500018', '2026-07-23 03:21:18'),
(22, '6371010101010001', '6371020101010001', 'Gilang Raka', 'Banjarmasin', '1983-10-11', 'Pengacara', 'S1', 'Jl. Mantuil No. 10', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500019', '2026-07-23 03:21:18'),
(23, '6371020101010002', '6371020101010001', 'Tuti Alawiyah', 'Banjarmasin', '1985-03-03', 'Guru', 'S1', 'Jl. Mantuil No. 10', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500020', '2026-07-23 03:21:18'),
(24, '6371010101011001', '6371020101011001', 'Slamet Riyadi', 'Banjarmasin', '1975-04-12', 'Buruh Harian', 'SMP', 'Jl. Mantuil No. 11', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500021', '2026-07-23 03:21:18'),
(25, '6371020101011002', '6371020101011001', 'Sumini', 'Banjarmasin', '1978-06-18', 'IRT', 'SD', 'Jl. Mantuil No. 11', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500022', '2026-07-23 03:21:18'),
(26, '6371010101011003', '6371020101011001', 'Andi Pratama', 'Banjarmasin', '2005-09-20', 'Pelajar', 'SMP', 'Jl. Mantuil No. 11', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(27, '6371010101012001', '6371020101012001', 'Kasman', 'Banjarmasin', '1976-01-25', 'Tukang Becak', 'SD', 'Jl. Mantuil No. 12', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500023', '2026-07-23 03:21:18'),
(28, '6371020101012002', '6371020101012001', 'Painem', 'Banjarmasin', '1979-05-14', 'IRT', 'SD', 'Jl. Mantuil No. 12', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500024', '2026-07-23 03:21:18'),
(29, '6371020101012003', '6371020101012001', 'Budi Setiawan', 'Banjarmasin', '2008-02-10', 'Pelajar', 'SD', 'Jl. Mantuil No. 12', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(30, '6371010101013001', '6371020101013001', 'Sutrisno', 'Banjarmasin', '1980-08-11', 'Buruh Pabrik', 'SMA', 'Jl. Mantuil No. 13', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500025', '2026-07-23 03:21:18'),
(31, '6371020101013002', '6371020101013001', 'Wartini', 'Banjarmasin', '1982-12-01', 'IRT', 'SMP', 'Jl. Mantuil No. 13', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500026', '2026-07-23 03:21:18'),
(32, '6371020101013003', '6371020101013001', 'Citra Lestari', 'Banjarmasin', '2010-07-22', 'Pelajar', 'SD', 'Jl. Mantuil No. 13', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(33, '6371010101014001', '6371020101014001', 'Darsono', 'Banjarmasin', '1972-03-15', 'Petani', 'SMP', 'Jl. Mantuil No. 14', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500027', '2026-07-23 03:21:18'),
(34, '6371020101014002', '6371020101014001', 'Ngatini', 'Banjarmasin', '1975-10-09', 'IRT', 'SD', 'Jl. Mantuil No. 14', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500028', '2026-07-23 03:21:18'),
(35, '6371010101014003', '6371020101014001', 'Doni Saputra', 'Banjarmasin', '2003-11-30', 'Mahasiswa', 'SMA', 'Jl. Mantuil No. 14', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(36, '6371010101015001', '6371020101015001', 'Mulyono', 'Banjarmasin', '1981-07-07', 'Satpam', 'SMA', 'Jl. Mantuil No. 15', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500029', '2026-07-23 03:21:18'),
(37, '6371020101015002', '6371020101015001', 'Sulastri', 'Banjarmasin', '1984-02-28', 'IRT', 'SMP', 'Jl. Mantuil No. 15', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500030', '2026-07-23 03:21:18'),
(38, '6371010101015003', '6371020101015001', 'Eka Putra', 'Banjarmasin', '2012-04-18', 'Pelajar', 'SD', 'Jl. Mantuil No. 15', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(39, '6371010101016001', '6371020101016001', 'Tukimin', 'Banjarmasin', '1977-09-22', 'Buruh', 'SMP', 'Jl. Mantuil No. 16', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500031', '2026-07-23 03:21:18'),
(40, '6371020101016002', '6371020101016001', 'Rumiyati', 'Banjarmasin', '1980-01-19', 'IRT', 'SD', 'Jl. Mantuil No. 16', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500032', '2026-07-23 03:21:18'),
(41, '6371010101016003', '6371020101016001', 'Fauzan', 'Banjarmasin', '2009-06-15', 'Pelajar', 'SD', 'Jl. Mantuil No. 16', '017', '005', 'Anak', '', 'Islam', 'Belum Kawin', '', '2026-07-23 03:21:18'),
(42, '6371010101017001', '6371020101017001', 'Surip', 'Banjarmasin', '1985-12-11', 'Guru Honorer', 'SMA', 'Jl. Mantuil No. 17', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500033', '2026-07-23 03:21:18'),
(43, '6371020101017002', '6371020101017001', 'Juminten', 'Banjarmasin', '1988-03-30', 'IRT', 'SMP', 'Jl. Mantuil No. 17', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500034', '2026-07-23 03:21:18'),
(44, '6371020101017003', '6371020101017001', 'Gilang Ramadhan', 'Banjarmasin', '2015-08-12', 'Pelajar', 'SD', 'Jl. Mantuil No. 17', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(45, '6371010101018001', '6371020101018001', 'Wawan Setiawan', 'Banjarmasin', '1979-05-05', 'Kuli Bangunan', 'SMP', 'Jl. Mantuil No. 18', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500035', '2026-07-23 03:21:18'),
(46, '6371020101018002', '6371020101018001', 'Suparmi', 'Banjarmasin', '1982-10-25', 'IRT', 'SD', 'Jl. Mantuil No. 18', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500036', '2026-07-23 03:21:18'),
(47, '6371010101018003', '6371020101018001', 'Hadi Kusuma', 'Banjarmasin', '2007-01-14', 'Pelajar', 'SMP', 'Jl. Mantuil No. 18', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(48, '6371010101019001', '6371020101019001', 'Yanto', 'Banjarmasin', '1973-02-18', 'Petani', 'SMP', 'Jl. Mantuil No. 19', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500037', '2026-07-23 03:21:18'),
(49, '6371020101019002', '6371020101019001', 'Kunarsih', 'Banjarmasin', '1976-11-09', 'IRT', 'SD', 'Jl. Mantuil No. 19', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500038', '2026-07-23 03:21:18'),
(50, '6371020101019003', '6371020101019001', 'Ika Pertiwi', 'Banjarmasin', '2006-12-01', 'Pelajar', 'SMP', 'Jl. Mantuil No. 19', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(51, '6371010101020001', '6371020101020001', 'Parmin', 'Banjarmasin', '1982-08-22', 'Buruh', 'SMA', 'Jl. Mantuil No. 20', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500039', '2026-07-23 03:21:18'),
(52, '6371020101020002', '6371020101020001', 'Tarmini', 'Banjarmasin', '1985-04-17', 'IRT', 'SMP', 'Jl. Mantuil No. 20', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500040', '2026-07-23 03:21:18'),
(53, '6371010101020003', '6371020101020001', 'Joko Anwar', 'Banjarmasin', '2011-09-29', 'Pelajar', 'SD', 'Jl. Mantuil No. 20', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(54, '6371010101021001', '6371020101021001', 'Ruslan', 'Banjarmasin', '1978-06-30', 'Tukang Parkir', 'SMP', 'Jl. Mantuil No. 21', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500041', '2026-07-23 03:21:18'),
(55, '6371020101021002', '6371020101021001', 'Saminah', 'Banjarmasin', '1981-03-12', 'IRT', 'SD', 'Jl. Mantuil No. 21', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500042', '2026-07-23 03:21:18'),
(56, '6371020101021003', '6371020101021001', 'Kiki Amalia', 'Banjarmasin', '2010-07-08', 'Pelajar', 'SD', 'Jl. Mantuil No. 21', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(57, '6371010101022001', '6371020101022001', 'Suharto', 'Banjarmasin', '1980-10-05', 'Buruh Harian', 'SMA', 'Jl. Mantuil No. 22', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500043', '2026-07-23 03:21:18'),
(58, '6371020101022002', '6371020101022001', 'Sumarni', 'Banjarmasin', '1983-01-28', 'IRT', 'SMP', 'Jl. Mantuil No. 22', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500044', '2026-07-23 03:21:18'),
(59, '6371010101022003', '6371020101022001', 'Lina Marlina', 'Banjarmasin', '2008-05-19', 'Pelajar', 'SD', 'Jl. Mantuil No. 22', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(60, '6371010101023001', '6371020101023001', 'Tarjo', 'Banjarmasin', '1975-12-22', 'Peternak', 'SMP', 'Jl. Mantuil No. 23', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500045', '2026-07-23 03:21:18'),
(61, '6371020101023002', '6371020101023001', 'Ngatini', 'Banjarmasin', '1978-08-14', 'IRT', 'SD', 'Jl. Mantuil No. 23', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500046', '2026-07-23 03:21:18'),
(62, '6371010101023003', '6371020101023001', 'Maman Suherman', 'Banjarmasin', '2004-02-11', 'Pelajar', 'SMA', 'Jl. Mantuil No. 23', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(63, '6371010101024001', '6371020101024001', 'Udin', 'Banjarmasin', '1986-09-09', 'Pengamen', 'SMP', 'Jl. Mantuil No. 24', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500047', '2026-07-23 03:21:18'),
(64, '6371020101024002', '6371020101024001', 'Munasir', 'Banjarmasin', '1989-11-02', 'IRT', 'SD', 'Jl. Mantuil No. 24', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500048', '2026-07-23 03:21:18'),
(65, '6371010101024003', '6371020101024001', 'Nanda Rio', 'Banjarmasin', '2013-04-25', 'Pelajar', 'SD', 'Jl. Mantuil No. 24', '017', '005', 'Anak', 'Laki-laki', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(66, '6371010101025001', '6371020101025001', 'Waluyo', 'Banjarmasin', '1983-07-19', 'Satpam', 'SMA', 'Jl. Mantuil No. 25', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500049', '2026-07-23 03:21:18'),
(67, '6371020101025002', '6371020101025001', 'Wiji Suwanti', 'Banjarmasin', '1986-10-30', 'IRT', 'SMP', 'Jl. Mantuil No. 25', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500050', '2026-07-23 03:21:18'),
(68, '6371020101025003', '6371020101025001', 'Oki Setiadi', 'Banjarmasin', '2014-12-12', 'Pelajar', 'SD', 'Jl. Mantuil No. 25', '017', '005', 'Anak', 'Perempuan', 'Islam', 'Belum Kawin', NULL, '2026-07-23 03:21:18'),
(69, '6371010101026001', '6371020101026001', 'Agus Salim', 'Banjarmasin', '1981-04-14', 'Karyawan Swasta', 'D3', 'Jl. Mantuil No. 26', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500051', '2026-07-23 03:21:18'),
(70, '6371020101026002', '6371020101026001', 'Rina Mega', 'Banjarmasin', '1983-09-21', 'Karyawan Swasta', 'D3', 'Jl. Mantuil No. 26', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500052', '2026-07-23 03:21:18'),
(71, '6371010101027001', '6371020101027001', 'Bambang Pamungkas', 'Banjarmasin', '1980-02-02', 'Polisi', 'SMA', 'Jl. Mantuil No. 27', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500053', '2026-07-23 03:21:18'),
(72, '6371020101027002', '6371020101027001', 'Sri Mulyani', 'Banjarmasin', '1982-06-15', 'IRT', 'SMA', 'Jl. Mantuil No. 27', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500054', '2026-07-23 03:21:18'),
(73, '6371010101028001', '6371020101028001', 'Cecep Ferdinand', 'Banjarmasin', '1979-12-09', 'Pedagang', 'SMA', 'Jl. Mantuil No. 28', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500055', '2026-07-23 03:21:18'),
(74, '6371020101028002', '6371020101028001', 'Yuni Eka', 'Banjarmasin', '1981-08-08', 'Pedagang', 'SMA', 'Jl. Mantuil No. 28', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500056', '2026-07-23 03:21:18'),
(75, '6371010101029001', '6371020101029001', 'Dadi Mulyadi', 'Banjarmasin', '1984-05-23', 'Karyawan BUMN', 'S1', 'Jl. Mantuil No. 29', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500057', '2026-07-23 03:21:18'),
(76, '6371020101029002', '6371020101029001', 'Wati Suryani', 'Banjarmasin', '1986-11-11', 'IRT', 'D3', 'Jl. Mantuil No. 29', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500058', '2026-07-23 03:21:18'),
(77, '6371010101030001', '6371020101030001', 'Eko Sulistyo', 'Banjarmasin', '1982-03-30', 'Teknisi', 'SMK', 'Jl. Mantuil No. 30', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500059', '2026-07-23 03:21:18'),
(78, '6371020101030002', '6371020101030001', 'Endang Susilowati', 'Banjarmasin', '1984-10-17', 'Karyawan Swasta', 'SMA', 'Jl. Mantuil No. 30', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500060', '2026-07-23 03:21:18'),
(79, '6371010101031001', '6371020101031001', 'Fauzan Arif', 'Banjarmasin', '1987-01-05', 'Guru Honorer', 'S1', 'Jl. Mantuil No. 31', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500061', '2026-07-23 03:21:18'),
(80, '6371020101031002', '6371020101031001', 'Gita Sari', 'Banjarmasin', '1989-07-28', 'Guru Honorer', 'S1', 'Jl. Mantuil No. 31', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500062', '2026-07-23 03:21:18'),
(81, '6371010101032001', '6371020101032001', 'Gunawan Wibisono', 'Banjarmasin', '1983-09-14', 'Karyawan Swasta', 'D3', 'Jl. Mantuil No. 32', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500063', '2026-07-23 03:21:18'),
(82, '6371020101032002', '6371020101032001', 'Hesti Purnama', 'Banjarmasin', '1985-02-19', 'IRT', 'SMA', 'Jl. Mantuil No. 32', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500064', '2026-07-23 03:21:18'),
(83, '6371010101033001', '6371020101033001', 'Hari Pranoto', 'Banjarmasin', '1980-11-01', 'Wiraswasta', 'SMA', 'Jl. Mantuil No. 33', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500065', '2026-07-23 03:21:18'),
(84, '6371020101033002', '6371020101033001', 'Ika Pratiwi', 'Banjarmasin', '1982-04-04', 'IRT', 'SMA', 'Jl. Mantuil No. 33', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500066', '2026-07-23 03:21:18'),
(85, '6371010101034001', '6371020101034001', 'Imam Syafii', 'Banjarmasin', '1985-08-21', 'Karyawan Bank', 'S1', 'Jl. Mantuil No. 34', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500067', '2026-07-23 03:21:18'),
(86, '6371020101034002', '6371020101034001', 'Julaika', 'Banjarmasin', '1988-12-23', 'Karyawan Swasta', 'D3', 'Jl. Mantuil No. 34', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500068', '2026-07-23 03:21:18'),
(87, '6371010101035001', '6371020101035001', 'Kiki Hamzah', 'Banjarmasin', '1981-06-18', 'PNS', 'S1', 'Jl. Mantuil No. 35', '017', '005', 'Kepala Keluarga', 'Laki-laki', 'Islam', 'Kawin', '081234500069', '2026-07-23 03:21:18'),
(88, '6371020101035002', '6371020101035001', 'Lina Rosmawati', 'Banjarmasin', '1983-10-27', 'Karyawan Swasta', 'S1', 'Jl. Mantuil No. 35', '017', '005', 'Istri', 'Perempuan', 'Islam', 'Kawin', '081234500070', '2026-07-23 03:21:18');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bantuan`
--
ALTER TABLE `bantuan`
  ADD PRIMARY KEY (`id_bantuan`),
  ADD KEY `id_warga` (`id_warga`);

--
-- Indeks untuk tabel `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id_laporan`);

--
-- Indeks untuk tabel `pembayaran_iuran`
--
ALTER TABLE `pembayaran_iuran`
  ADD PRIMARY KEY (`id_iuran`),
  ADD KEY `id_warga` (`id_warga`),
  ADD KEY `fk_iuran_user` (`dicatat_oleh`);

--
-- Indeks untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`id_pengaduan`),
  ADD KEY `id_warga` (`id_warga`);

--
-- Indeks untuk tabel `pengajuan_surat`
--
ALTER TABLE `pengajuan_surat`
  ADD PRIMARY KEY (`id_surat`),
  ADD KEY `id_warga` (`id_warga`),
  ADD KEY `fk_surat_user` (`diproses_oleh`);

--
-- Indeks untuk tabel `pengaturan`
--
ALTER TABLE `pengaturan`
  ADD PRIMARY KEY (`id_setting`);

--
-- Indeks untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id_pengumuman`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `profil_sosial_warga`
--
ALTER TABLE `profil_sosial_warga`
  ADD PRIMARY KEY (`id_profil`),
  ADD KEY `id_warga` (`id_warga`);

--
-- Indeks untuk tabel `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`id_tamu`);

--
-- Indeks untuk tabel `transaksi_kas`
--
ALTER TABLE `transaksi_kas`
  ADD PRIMARY KEY (`id_kas`),
  ADD KEY `fk_kas_user` (`dicatat_oleh`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_warga` (`id_warga`);

--
-- Indeks untuk tabel `warga`
--
ALTER TABLE `warga`
  ADD PRIMARY KEY (`id_warga`),
  ADD UNIQUE KEY `nik` (`nik`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bantuan`
--
ALTER TABLE `bantuan`
  MODIFY `id_bantuan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id_laporan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pembayaran_iuran`
--
ALTER TABLE `pembayaran_iuran`
  MODIFY `id_iuran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  MODIFY `id_pengaduan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pengajuan_surat`
--
ALTER TABLE `pengajuan_surat`
  MODIFY `id_surat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pengaturan`
--
ALTER TABLE `pengaturan`
  MODIFY `id_setting` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id_pengumuman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `profil_sosial_warga`
--
ALTER TABLE `profil_sosial_warga`
  MODIFY `id_profil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT untuk tabel `tamu`
--
ALTER TABLE `tamu`
  MODIFY `id_tamu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_kas`
--
ALTER TABLE `transaksi_kas`
  MODIFY `id_kas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `warga`
--
ALTER TABLE `warga`
  MODIFY `id_warga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bantuan`
--
ALTER TABLE `bantuan`
  ADD CONSTRAINT `bantuan_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pembayaran_iuran`
--
ALTER TABLE `pembayaran_iuran`
  ADD CONSTRAINT `fk_iuran_user` FOREIGN KEY (`dicatat_oleh`) REFERENCES `users` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `pembayaran_iuran_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD CONSTRAINT `pengaduan_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengajuan_surat`
--
ALTER TABLE `pengajuan_surat`
  ADD CONSTRAINT `fk_surat_user` FOREIGN KEY (`diproses_oleh`) REFERENCES `users` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `pengajuan_surat_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD CONSTRAINT `pengumuman_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `profil_sosial_warga`
--
ALTER TABLE `profil_sosial_warga`
  ADD CONSTRAINT `profil_sosial_warga_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi_kas`
--
ALTER TABLE `transaksi_kas`
  ADD CONSTRAINT `fk_kas_user` FOREIGN KEY (`dicatat_oleh`) REFERENCES `users` (`id_user`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
