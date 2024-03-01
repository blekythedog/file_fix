-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2024 at 01:14 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ukk_kasir`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(4) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `kode_barang` varchar(50) NOT NULL,
  `harga` int(50) NOT NULL,
  `stok` int(50) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `kode_barang`, `harga`, `stok`, `tanggal`) VALUES
(29, 'baju xxl', 'exe', 10000, 698, '2024-02-29'),
(30, 'baju xl', 'exe', 30000, 0, '2024-02-29'),
(31, 'baju m', 'exe', 50000, 6500, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` int(4) NOT NULL,
  `id_barang` int(4) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `jumlah` int(5) NOT NULL,
  `tanggal_masuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `id_barang`, `nama_supplier`, `jumlah`, `tanggal_masuk`) VALUES
(20, 24, 'richard', 90000, '2024-02-28'),
(21, 23, 'hoho', 50, '2024-02-28'),
(22, 25, 'asep', 578, '2024-02-28'),
(23, 28, 'richard', 7890, '2024-02-28'),
(24, 26, 'gogogo', 345, '2024-02-28'),
(25, 27, 'richard', 897645, '2024-02-28'),
(26, 29, 'richard', 700, '2024-02-29'),
(27, 31, 'richard', 6500, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(4) NOT NULL,
  `id_user` int(4) NOT NULL,
  `keranjang` varchar(50) NOT NULL,
  `pelanggan` varchar(60) NOT NULL,
  `total_pesan` int(4) NOT NULL,
  `harga` int(10) NOT NULL,
  `kembalian` int(100) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_user`, `keranjang`, `pelanggan`, `total_pesan`, `harga`, `kembalian`, `tanggal`) VALUES
(15, 0, 'baju xl', 'richard', 2, 60000, 0, '2024-02-29'),
(16, 0, 'baju m', 'richard', 3, 150000, 0, '2024-02-29'),
(17, 0, 'baju xl', 'ee', 3, 90000, 0, '2024-02-29'),
(20, 0, 'baju xl', 'richard', 5, 150000, 0, '2024-02-29'),
(21, 0, 'baju m', 'richaed', 4, 200000, 0, '2024-02-29'),
(22, 0, 'baju xl', 'foco', 2, 60000, 10000, '2024-02-29'),
(23, 0, 'baju xl', 'wewe', 3, 90000, 10000, '2024-02-29'),
(24, 0, 'baju xxl', 'hohohohohohoho', 10, 100000, 20000, '2024-02-29'),
(25, 0, 'baju xl', 'richard', 6, 180000, 20000, '2024-02-29'),
(26, 0, 'baju xl', 'helepee', 5, 150000, 50000, '2024-02-29'),
(27, 0, 'baju xxl', 'richard', 10, 1000000, 1000000, '2024-02-29'),
(28, 0, 'baju xxl', 'rjrjr', 2, 60000, 0, '2024-02-29');

--
-- Triggers `keranjang`
--
DELIMITER $$
CREATE TRIGGER `delete_stok_after_keranjang` AFTER DELETE ON `keranjang` FOR EACH ROW BEGIN
    UPDATE barang
    SET stok = stok + OLD.total_pesan
    WHERE nama_barang = OLD.keranjang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stok_after_keranjang` AFTER INSERT ON `keranjang` FOR EACH ROW BEGIN
    UPDATE barang
    SET stok = stok - NEW.total_pesan
    WHERE nama_barang = NEW.keranjang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id_log` int(4) NOT NULL,
  `id_barang_masuk` int(4) NOT NULL,
  `log` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(4) NOT NULL,
  `pelanggan` varchar(50) NOT NULL,
  `keranjang` varchar(50) NOT NULL,
  `harga` int(50) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `pelanggan`, `keranjang`, `harga`, `tanggal`) VALUES
(1, 'richard', '', 1000000, '2024-02-29'),
(2, 'rjrjr', '', 60000, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(4) NOT NULL,
  `transaksi` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(4) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `level`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1),
(2, 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang_masuk`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_barang_masuk` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id_log` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
