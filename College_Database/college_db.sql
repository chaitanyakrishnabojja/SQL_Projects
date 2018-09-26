-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2018 at 10:55 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `college_db`
--
DROP DATABASE IF EXISTS college_db;
CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;
-- --------------------------------------------------------

--
-- Table structure for table `college`
--

CREATE TABLE `college` (
  `college_id` int(11) NOT NULL,
  `college_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `college`
--

INSERT INTO `college` (`college_id`, `college_name`) VALUES
(2, 'Centennial'),
(1, 'Conestoga'),
(3, 'Humber'),
(4, 'Windsor');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(45) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `dept_id`, `instructor_id`) VALUES
(1, 'Web Design and Development', 1, 1),
(2, 'ITBA', 1, 2),
(3, 'Network Security', 1, 2),
(4, 'Business Management', 2, 3),
(5, 'Mobile Solutions', 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(45) NOT NULL,
  `college_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `college_id`) VALUES
(1, 'ECE', 1),
(2, 'CSE', 1),
(3, 'Civil Engineering', 2),
(4, 'Mechanical Engineering', 3),
(5, 'Electrical Engineering', 4);

-- --------------------------------------------------------

--
-- Table structure for table `head`
--

CREATE TABLE `head` (
  `head_id` int(11) NOT NULL,
  `head_name` varchar(45) NOT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `dept_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `head`
--

INSERT INTO `head` (`head_id`, `head_name`, `instructor_id`, `dept_id`) VALUES
(1, 'john', NULL, 1),
(2, 'xyz', 3, 2),
(3, 'lmn', 4, 3),
(4, 'vijay', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL,
  `instructor_name` varchar(45) NOT NULL,
  `dept_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`instructor_id`, `instructor_name`, `dept_id`) VALUES
(1, 'abc', 1),
(2, 'lmn', 1),
(3, 'xyz', 2),
(4, 'lmn', 3),
(5, 'joel', 4),
(6, 'rajan', 5);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `student_first_name` varchar(45) NOT NULL,
  `student_last_name` varchar(45) NOT NULL,
  `student_email` varchar(45) NOT NULL,
  `student_phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `student_first_name`, `student_last_name`, `student_email`, `student_phone`) VALUES
(1, 'virat', 'kohli', 'kohli@gmail.com', '2222222222'),
(2, 'rohit', 'sharma', 'rohit@gmail.com', '3333333333'),
(3, 'dawan', 'sekhar', 'dawan@gmail.com', '4444444444'),
(4, 'vijay', 'hgvhjg', 'kvijay@gmail.com', '5555555555'),
(5, 'rahul', 'kl', 'rahul@gmail.com', '6666666666');

-- --------------------------------------------------------

--
-- Table structure for table `student_has_course`
--

CREATE TABLE `student_has_course` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student_has_course`
--

INSERT INTO `student_has_course` (`student_id`, `course_id`) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `college`
--
ALTER TABLE `college`
  ADD PRIMARY KEY (`college_id`),
  ADD UNIQUE KEY `college_id_UNIQUE` (`college_id`),
  ADD UNIQUE KEY `college_name_UNIQUE` (`college_name`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_id_UNIQUE` (`course_id`),
  ADD UNIQUE KEY `course_name_UNIQUE` (`course_name`),
  ADD KEY `fk_Course_Department1_idx` (`dept_id`),
  ADD KEY `fk_Course_Instructor1_idx` (`instructor_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`),
  ADD UNIQUE KEY `dept_id_UNIQUE` (`dept_id`),
  ADD KEY `fk_Department_College_idx` (`college_id`);

--
-- Indexes for table `head`
--
ALTER TABLE `head`
  ADD PRIMARY KEY (`head_id`),
  ADD UNIQUE KEY `head_id_UNIQUE` (`head_id`),
  ADD KEY `fk_Head_Instructor1_idx` (`instructor_id`),
  ADD KEY `fk_Head_Department1_idx` (`dept_id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`instructor_id`),
  ADD UNIQUE KEY `instructor_id_UNIQUE` (`instructor_id`),
  ADD KEY `fk_Instructor_Department1_idx` (`dept_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_id_UNIQUE` (`student_id`),
  ADD UNIQUE KEY `student_email_UNIQUE` (`student_email`),
  ADD UNIQUE KEY `student_phone_UNIQUE` (`student_phone`);

--
-- Indexes for table `student_has_course`
--
ALTER TABLE `student_has_course`
  ADD PRIMARY KEY (`student_id`,`course_id`),
  ADD KEY `fk_Student_has_Course_Course1_idx` (`course_id`),
  ADD KEY `fk_Student_has_Course_Student1_idx` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `college`
--
ALTER TABLE `college`
  MODIFY `college_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `head`
--
ALTER TABLE `head`
  MODIFY `head_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `instructor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `fk_Course_Department1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Course_Instructor1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_Department_College` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `head`
--
ALTER TABLE `head`
  ADD CONSTRAINT `fk_Head_Department1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Head_Instructor1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `instructor`
--
ALTER TABLE `instructor`
  ADD CONSTRAINT `fk_Instructor_Department1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `student_has_course`
--
ALTER TABLE `student_has_course`
  ADD CONSTRAINT `fk_Student_has_Course_Course1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Student_has_Course_Student1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
