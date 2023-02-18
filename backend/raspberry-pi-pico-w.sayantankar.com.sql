-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 18, 2023 at 04:03 PM
-- Server version: 10.5.16-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u483648335_raspberrypip`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth`
--

INSERT INTO `auth` (`id`, `username`, `password`) VALUES
(1, 'nsec', 'nsec1234'),
(2, 'students', 'students1234'),
(3, 'sayantan', '9614975333'),
(4, 'adway', '9875360868'),
(5, 'suhana', '7003375490'),
(6, 'debosmita', '8902424868'),
(7, 'kabir', '7550812909');

-- --------------------------------------------------------

--
-- Table structure for table `gate_auth`
--

CREATE TABLE `gate_auth` (
  `id` int(11) NOT NULL,
  `has` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL COMMENT 'create, \r\nopen, \r\nclose, \r\nex-open, \r\nex-close, \r\n',
  `gate_open_by` varchar(100) NOT NULL,
  `gate_open_time` varchar(100) NOT NULL,
  `gate_open_position` varchar(100) NOT NULL,
  `gate_auth_close_time` varchar(100) NOT NULL,
  `gate_auth_close_position` varchar(100) NOT NULL,
  `gate_auto_close_time` varchar(100) NOT NULL,
  `exit_time` varchar(100) NOT NULL DEFAULT '0',
  `exit_position` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gate_auth`
--

INSERT INTO `gate_auth` (`id`, `has`, `time`, `status`, `gate_open_by`, `gate_open_time`, `gate_open_position`, `gate_auth_close_time`, `gate_auth_close_position`, `gate_auto_close_time`, `exit_time`, `exit_position`) VALUES
(1, 'HAS_63f0e5bff1536', '1676731839988', 'ex-close', 'sayantan', '1676731956197', '0,0', '1676732009205', '0,0', '', '1676732128614', '0,0'),
(2, 'HAS_63f0e69ae4b68', '1676732058936', 'create', '', '', '', '', '', '', '0', ''),
(3, 'HAS_63f0ea37b23a0', '1676732983730', 'ex-close', 'sayantan', '1676732993483', '0,0', '1676733000203', '0,0', '', '1676733008615', '0,0'),
(4, 'HAS_63f0ec45759c2', '1676733509481', 'ex-open', 'sayantan', '1676733524611', '22.4725975,88.4089719', '', '', '1676733564885', '1676735540645', '22.4725973,88.4089698');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gate_auth`
--
ALTER TABLE `gate_auth`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth`
--
ALTER TABLE `auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `gate_auth`
--
ALTER TABLE `gate_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
