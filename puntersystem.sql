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
-- Dumping data for table `betslips`
--

INSERT INTO `betslips` (`s/n`, `slip_id`, `game_id`, `choice`, `bet_date`, `bet_amount`, `pot_win`, `result`, `status`) VALUES
(1, '4bd6f3f7-5ef5-4922-ae7f-311396f25317', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Home', '2022-10-09 13:25:39', 2500, 3300, 'U', 0),
(2, 'eb9ab05f-53d3-4aca-92ff-3a94cfb4bf23', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Away', '2022-10-09 13:26:32', 1000, 2150, 'U', 0),
(3, 'c9e6c91d-2986-4975-add0-d8154a4abe5f', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Home', '2022-10-09 19:49:50', 1250, 1650, 'U', 0),
(4, '66c8a8f7-b39d-4ed4-bd3a-bc6c03fc0cd8', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Draw', '2022-10-09 19:59:01', 950, 3562.5, 'U', 0),
(5, '79c5f974-4545-4b3a-a707-2edbde7de26c', 'c8133c5e-e35c-498c-8b6c-32d5542a2513', 'Tail', '2022-10-09 20:21:09', 1500, 3000, 'U', 0),
(6, '0f288d73-d5ab-46a5-9333-5a7963d4457a', 'c8133c5e-e35c-498c-8b6c-32d5542a2513', 'Tail', '2022-10-09 20:23:27', 1000, 2000, 'U', 0);

-- --------------------------------------------------------

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
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`sn`, `choice_id`, `game_id`, `choice`, `odd`, `status`) VALUES
(1, '5d886530-56c5-48b0-9ba8-6f1853141a7b', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Home', 1.32, 0),
(2, '8a17da89-6f3d-4728-8554-3f753bb26b28', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Draw', 3.75, 0),
(3, '29222597-2568-4da3-b565-b5069847df62', '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', 'Away', 2.15, 0),
(4, '59ec1a1a-496b-44f2-ab05-d790ad9f26ab', 'c8133c5e-e35c-498c-8b6c-32d5542a2513', 'Head', 2, 0),
(5, 'a50cb37a-407d-426a-b9f9-a28ca5a864d0', 'c8133c5e-e35c-498c-8b6c-32d5542a2513', 'Tail', 2, 0);

-- --------------------------------------------------------

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

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`sn`, `game_id`, `ref_id`, `fixture`, `outcome`, `dated`, `status`, `counter`) VALUES
(1, '3f0cd52e-277b-49e5-b1b3-5a90c1baf837', '3F0CD52E', 'ManCity vs ManUtd', NULL, '2022-10-09 13:25:02', 0, 4),
(2, 'c8133c5e-e35c-498c-8b6c-32d5542a2513', 'C8133C5E', 'Head or Tail Game', NULL, '2022-10-09 20:02:29', 0, 2);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
