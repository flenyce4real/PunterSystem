-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 09, 2022 at 07:58 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `puntersystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `betslips`
--

DROP TABLE IF EXISTS `betslips`;
CREATE TABLE IF NOT EXISTS `betslips` (
  `s/n` int(11) NOT NULL AUTO_INCREMENT,
  `slip_id` varchar(50) NOT NULL,
  `game_id` varchar(50) NOT NULL,
  `choice` varchar(50) NOT NULL,
  `bet_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bet_amount` int(11) NOT NULL,
  `pot_win` double NOT NULL,
  `result` enum('U','W','L') DEFAULT 'U',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slip_id`),
  UNIQUE KEY `sn` (`s/n`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Table structure for table `choices`
--

DROP TABLE IF EXISTS `choices`;
CREATE TABLE IF NOT EXISTS `choices` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `choice_id` varchar(50) NOT NULL,
  `game_id` varchar(50) NOT NULL,
  `choice` varchar(50) NOT NULL,
  `odd` float NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `sn` (`sn`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
CREATE TABLE IF NOT EXISTS `games` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `ref_id` varchar(10) NOT NULL,
  `fixture` varchar(100) NOT NULL,
  `outcome` varchar(50) DEFAULT NULL,
  `dated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '0',
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `sn` (`sn`),
  UNIQUE KEY `ref_id` (`ref_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;