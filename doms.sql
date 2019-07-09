-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2019 at 12:44 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doms`
--

-- --------------------------------------------------------

--
-- Table structure for table `academics`
--

CREATE TABLE `academics` (
  `subjectcode` varchar(10) NOT NULL,
  `subname` varchar(30) NOT NULL,
  `credits` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `academics`
--

INSERT INTO `academics` (`subjectcode`, `subname`, `credits`) VALUES
('uis053e', 'python', 3),
('uis054e', 'ajp', 3);

-- --------------------------------------------------------

--
-- Table structure for table `counsellor`
--

CREATE TABLE `counsellor` (
  `faculty` varchar(40) NOT NULL,
  `academicyear` varchar(15) NOT NULL,
  `usn` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `counsellor`
--

INSERT INTO `counsellor` (`faculty`, `academicyear`, `usn`) VALUES
('prof s.p.bangarshetti', '2017-2018', '2ba15is014'),
('prof s.p.bangarshetti', '2017-2018', '2ba15is002'),
('prof s.p.bangarshetti', '2017-2018', '2ba15is090'),
('prof preeti purnaik', '2017-2018', '2ba15is004'),
('prof preeti purnaik', '2017-2018', '2ba16is401');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `fid` int(10) NOT NULL,
  `faculty` varchar(40) NOT NULL,
  `designation` varchar(10) NOT NULL,
  `date_of_join` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`fid`, `faculty`, `designation`, `date_of_join`) VALUES
(1, 'prof preeti purnaik', 'asst prof', '2001-04-22'),
(2, 'prof s.p.bangarshetti', ' prof', '2000-02-05');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(10) NOT NULL,
  `username` varchar(10) NOT NULL,
  `pwd` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `pwd`) VALUES
(1, 'admin', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `projectgroups`
--

CREATE TABLE `projectgroups` (
  `teamno` int(11) NOT NULL,
  `usn` varchar(11) NOT NULL,
  `topic` varchar(70) NOT NULL,
  `guide` varchar(30) NOT NULL,
  `academicyear` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projectgroups`
--

INSERT INTO `projectgroups` (`teamno`, `usn`, `topic`, `guide`, `academicyear`) VALUES
(1, '2ba15is004', 'DOMS', 'prof s.p.bangarshetti', '2017-2018'),
(1, '2ba15is014', 'DOMS', 'prof s.p.bangarshetti', '2017-2018'),
(1, '2ba15is090', 'DOMS', 'prof s.p.bangarshetti', '2017-2018'),
(2, '2ba16is401', 'Student system', 'prof preeti purnaik', '2017-2018'),
(2, '2ba15is002', 'Student system', 'prof preeti purnaik', '2017-2018');

-- --------------------------------------------------------

--
-- Table structure for table `rollcall`
--

CREATE TABLE `rollcall` (
  `rlno` int(11) NOT NULL,
  `usn` varchar(10) NOT NULL,
  `academicyear` varchar(15) NOT NULL,
  `division` varchar(15) NOT NULL,
  `semester` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rollcall`
--

INSERT INTO `rollcall` (`rlno`, `usn`, `academicyear`, `division`, `semester`) VALUES
(1, '2ba15is002', '2017-2018', 'B DIVISION', 6),
(2, '2ba15is004', '2017-2018', 'B DIVISION', 6),
(3, '2ba15is004', '2017-2018', 'B DIVISION', 6),
(4, '2ba15is090', '2017-2018', 'B DIVISION', 6),
(5, '2ba16is401', '2017-2018', 'B DIVISION', 6);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `slno` int(5) NOT NULL,
  `name` varchar(40) NOT NULL,
  `usn` varchar(10) NOT NULL,
  `csn` int(15) NOT NULL,
  `mobileno` varchar(11) NOT NULL,
  `emailid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`slno`, `name`, `usn`, `csn`, `mobileno`, `emailid`) VALUES
(5, 'avinash', '2ba16is401', 22432354, '7019766434', 'xyz@gmail.com'),
(6, 'Abhishek', '2ba15is004', 22432354, '7019766434', 'abhishek@yahoo.com'),
(7, 'Ajey Ghale', '2ba15is014', 23446555, '9243924890', 'ajeyghale@gmail.com'),
(8, 'Yeshwanth M', '2ba15is090', 23446570, '9243924848', 'yesh@gmail.com'),
(9, 'Abhishk M K', '2ba15is002', 23446553, '9243923824', 'abhimk@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `subjectallotment`
--

CREATE TABLE `subjectallotment` (
  `slno` int(5) NOT NULL,
  `subjectcode` varchar(10) NOT NULL,
  `faculty` varchar(30) NOT NULL,
  `ayear` varchar(10) NOT NULL,
  `sem` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subjectallotment`
--

INSERT INTO `subjectallotment` (`slno`, `subjectcode`, `faculty`, `ayear`, `sem`) VALUES
(1, 'uis053e', 'prof s.p.bangarshetti', '2017-2018', 'Even'),
(2, 'uis054e', 'prof preeti purnaik', '2017-2018', 'Even');

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `image` longblob NOT NULL,
  `academicyear` varchar(9) NOT NULL,
  `sem` varchar(4) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `timetable`
--

INSERT INTO `timetable` (`id`, `name`, `image`, `academicyear`, `sem`, `type`) VALUES
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;