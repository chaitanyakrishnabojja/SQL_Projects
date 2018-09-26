-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 09, 2018 at 09:58 PM
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
-- Database: `hotelchain`
--
DROP DATABASE IF EXISTS hotelchain;
CREATE DATABASE hotelchain;
USE hotelchain;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_booking_count_year` (`guest_name_param` VARCHAR(45), `year_param` DATE)  BEGIN
SELECT guest_name, COUNT(booking_id) AS no_of_bookings					-- used COUNT() function
FROM guests JOIN booking												-- joined guests and booking tables
		ON guests.guest_id = booking.guest_id
WHERE (YEAR(booked_from_date) = year_param) OR (YEAR(booked_to_date) = year_param)		-- filtering bookings in year 2018
GROUP BY guest_name
HAVING guest_name = guest_name_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_hotel_available_rooms` (`hotel_name_param` VARCHAR(45), `date_param` DATE)  BEGIN										-- starting query
SELECT hotel_name, total_rooms, SUM(booking_room_count) AS booked_rooms, (total_rooms - SUM(booking_room_count)) AS available_rooms		-- used SUM() function
FROM hotel_rooms_total JOIN booking						-- joined hotel_rooms_total view and booking table
		ON hotel_rooms_total.hotel_id = booking.hotel_id
WHERE date_param BETWEEN booked_from_date AND booked_to_date		-- condition
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `guests_count_month` (`month_param` INT)  BEGIN
SELECT COUNT(DISTINCT booking.guest_id)	AS customers_count_month					-- used count function and distinct keyword
FROM guests JOIN booking									-- joining guests and booking
		ON guests.guest_id = booking.guest_id
WHERE (MONTH(booked_from_date)) = month_param OR (MONTH(booked_to_date) = month_param);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hotel_rooms_available` (`hotel_name_param` VARCHAR(45), `today` DATE)  BEGIN
SELECT hotel_name, total_rooms, SUM(booking_room_count) AS booked_rooms, (total_rooms - SUM(booking_room_count)) AS available_rooms		-- used SUM() function
FROM hotel_rooms_total JOIN booking						-- joined hotel_rooms_total view and booking table
		ON hotel_rooms_total.hotel_id = booking.hotel_id
WHERE today BETWEEN booked_from_date AND booked_to_date		-- condition
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rooms_booked_hotel_date` (`hotel_name_param` VARCHAR(45), `date_param` DATE)  BEGIN
SELECT hotel_name, COUNT(booking_room_count) AS rooms_booked			-- used count() function
FROM hotel JOIN booking													-- joined hotel and booking
		ON hotel.hotel_id = booking.hotel_id
WHERE date_param BETWEEN booked_from_date AND booked_to_date			-- applying condition by date
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_date` datetime NOT NULL,
  `booked_from_date` date NOT NULL,
  `booked_to_date` date NOT NULL,
  `booking_room_count` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `booking_type_id` int(11) NOT NULL,
  `guest_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_date`, `booked_from_date`, `booked_to_date`, `booking_room_count`, `hotel_id`, `room_type_id`, `booking_type_id`, `guest_id`) VALUES
(1, '2018-01-23 00:00:00', '2018-04-15', '2018-04-18', 1, 1, 2, 1, 1),
(2, '2018-02-02 00:00:00', '2018-04-16', '2018-04-17', 2, 1, 2, 1, 2),
(3, '2018-02-04 00:00:00', '2018-04-11', '2018-04-15', 1, 2, 1, 2, 3),
(4, '2018-02-04 00:00:00', '2018-04-11', '2018-04-16', 2, 3, 3, 2, 4),
(5, '2018-02-07 00:00:00', '2018-04-23', '2018-04-25', 1, 4, 2, 1, 5),
(6, '2018-02-08 00:00:00', '2018-04-16', '2018-04-20', 1, 5, 1, 1, 6),
(7, '2018-02-08 00:00:00', '2018-04-11', '2018-04-15', 2, 2, 1, 1, 3),
(8, '2018-02-10 00:00:00', '2018-04-16', '2018-04-22', 1, 4, 3, 1, 7),
(9, '2018-02-10 00:00:00', '2018-04-10', '2018-04-18', 1, 5, 1, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `booking_type`
--

CREATE TABLE `booking_type` (
  `booking_type_id` int(11) NOT NULL,
  `booking_type` enum('ONLINE','OFFLINE') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking_type`
--

INSERT INTO `booking_type` (`booking_type_id`, `booking_type`) VALUES
(1, 'ONLINE'),
(2, 'OFFLINE');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`country_id`, `country_name`) VALUES
(5, 'Australia'),
(3, 'Canada'),
(1, 'India'),
(4, 'Paris'),
(2, 'United States');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `employee_name` varchar(45) NOT NULL,
  `employee_address` varchar(45) NOT NULL,
  `employee_city` varchar(45) NOT NULL,
  `employee_zipcode` varchar(45) NOT NULL,
  `employee_province` varchar(45) NOT NULL,
  `hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `employee_name`, `employee_address`, `employee_city`, `employee_zipcode`, `employee_province`, `hotel_id`) VALUES
(1, 'Rohit', '120 Weber St', 'Kitchener', 'N2A1Y3', 'ON', 1),
(2, 'Dhawan', '125 Franklin St', 'Kitchener', 'N2C1Y6', 'ON', 1),
(3, 'Kohli', '3370 King St', 'Waterloo', 'N2C2P6', 'ON', 2),
(4, 'Dhoni', '593 Queen St', 'Ottawa', 'N4C7V5', 'ON', 2),
(5, 'Rahul', '3554 Weber St', 'Toronto', 'N4D8R6', 'ON', 3);

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `guest_id` int(11) NOT NULL,
  `guest_name` varchar(45) NOT NULL,
  `guest_address_line1` varchar(45) NOT NULL,
  `guest_city` varchar(45) NOT NULL,
  `guest_state` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`guest_id`, `guest_name`, `guest_address_line1`, `guest_city`, `guest_state`) VALUES
(1, 'Jadeja', '321 Raman St', 'Vizag', 'AP'),
(2, 'Ashwin', '7355 King St', 'Delhi', 'Delhi'),
(3, 'Pollard', '5789 tragda', 'Banglore', 'KA'),
(4, 'Deviliers', '489 gasdadgg st', 'Pondichery', 'TN'),
(5, 'Morkel', '6578 Morkwl St', 'Rangastalam', 'AP'),
(6, 'Pollock', 'Pollock St', 'Katmandu', 'KE'),
(7, 'Patel', 'Patel St', 'Rjy', 'AP'),
(8, 'Yadav', 'Yadav St', 'Mumbai', 'MP');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(45) NOT NULL,
  `address_line1` varchar(45) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `hotel_url` varchar(45) DEFAULT NULL,
  `hotel_chain_id` int(11) NOT NULL,
  `hotel_rating` decimal(2,1) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `hotel_name`, `address_line1`, `zip_code`, `city`, `description`, `hotel_url`, `hotel_chain_id`, `hotel_rating`, `country_id`) VALUES
(1, 'Radisson King', '12 Gachibowli', '947739', 'Warangal', 'Spectacular Look', 'www.radissonKing.com', 1, '5.0', 1),
(2, 'Radisson Queen', '156 Miyapur', '578337', 'Hyderabad', 'Luxurious', 'www.radissonQueen.com', 1, '4.0', 2),
(3, 'Yati King', '4356 Ameerpet', '684764', 'Vijayawada', 'average', 'www.yatiKing.com', 2, '3.0', 3),
(4, 'Paradise King', '432 Gachibowli', '4626554', 'Amaravathi', 'sea side', 'www.paradiseKing.com', 3, '4.0', 4),
(5, 'Bawarchi Queen', '9786 Gachibowli', '947739', 'Hyderabad', 'includes family restaurent', NULL, 4, '5.0', 5);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_chains`
--

CREATE TABLE `hotel_chains` (
  `hotel_chain_id` int(11) NOT NULL,
  `hotel_chain_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hotel_chains`
--

INSERT INTO `hotel_chains` (`hotel_chain_id`, `hotel_chain_name`) VALUES
(4, 'Bawarchi'),
(3, 'Paradise'),
(1, 'Radisson'),
(2, 'Yati');

-- --------------------------------------------------------

--
-- Stand-in structure for view `hotel_rooms_total`
-- (See below for the actual view)
--
CREATE TABLE `hotel_rooms_total` (
`hotel_id` int(11)
,`hotel_name` varchar(45)
,`total_rooms` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `periods`
--

CREATE TABLE `periods` (
  `period_id` int(11) NOT NULL,
  `discount_period` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `periods`
--

INSERT INTO `periods` (`period_id`, `discount_period`) VALUES
(2, 'Aug - Sep'),
(1, 'Jan - Feb');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `hotel_rating` decimal(2,1) NOT NULL,
  `rate_image` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`hotel_rating`, `rate_image`) VALUES
('1.0', ''),
('2.0', ''),
('3.0', ''),
('4.0', ''),
('5.0', '');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_no` int(11) NOT NULL,
  `floor_no` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_no`, `floor_no`, `hotel_id`, `room_type_id`) VALUES
(101, 1, 1, 3),
(201, 2, 1, 3),
(301, 3, 1, 3),
(401, 4, 1, 3),
(501, 5, 1, 3),
(102, 1, 1, 1),
(202, 2, 1, 1),
(302, 3, 1, 1),
(402, 4, 1, 1),
(502, 5, 1, 1),
(103, 1, 1, 2),
(203, 2, 1, 2),
(303, 3, 1, 2),
(403, 4, 1, 2),
(503, 5, 1, 2),
(101, 1, 2, 3),
(201, 2, 2, 3),
(301, 3, 2, 3),
(102, 1, 2, 1),
(202, 2, 2, 1),
(302, 3, 2, 1),
(103, 1, 2, 2),
(203, 2, 2, 2),
(303, 3, 2, 2),
(101, 1, 3, 3),
(201, 2, 3, 3),
(301, 3, 3, 3),
(401, 4, 3, 3),
(102, 1, 3, 1),
(202, 2, 3, 1),
(302, 3, 3, 1),
(402, 4, 3, 1),
(103, 1, 3, 2),
(203, 2, 3, 2),
(303, 3, 3, 2),
(403, 4, 3, 2),
(101, 1, 4, 3),
(201, 2, 4, 3),
(301, 3, 4, 3),
(401, 4, 4, 3),
(501, 5, 4, 3),
(102, 1, 4, 1),
(202, 2, 4, 1),
(302, 3, 4, 1),
(402, 4, 4, 1),
(502, 5, 4, 1),
(103, 1, 4, 2),
(203, 2, 4, 2),
(303, 3, 4, 2),
(403, 4, 4, 2),
(503, 5, 4, 2),
(101, 1, 5, 3),
(102, 1, 5, 1),
(103, 1, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `room_description` varchar(100) DEFAULT NULL,
  `room_standard_cost` decimal(6,2) NOT NULL,
  `room_capacity` int(11) NOT NULL,
  `smoking_A/NA` enum('YES','NO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_type`
--

INSERT INTO `room_type` (`room_type_id`, `room_type`, `room_description`, `room_standard_cost`, `room_capacity`, `smoking_A/NA`) VALUES
(1, 'Gold', 'Luxurious Rooms', '200.00', 4, 'NO'),
(2, 'Platinum', 'Royal Rooms', '300.00', 4, 'YES'),
(3, 'Silver', 'Cheapest Rooms', '100.00', 2, 'YES');

-- --------------------------------------------------------

--
-- Table structure for table `special_rates`
--

CREATE TABLE `special_rates` (
  `room_type_id` int(11) NOT NULL,
  `room_cost` int(11) NOT NULL,
  `period_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `special_rates`
--

INSERT INTO `special_rates` (`room_type_id`, `room_cost`, `period_id`) VALUES
(1, 150, 1),
(1, 160, 2),
(2, 180, 1),
(2, 200, 2),
(3, 80, 1);

-- --------------------------------------------------------

--
-- Structure for view `hotel_rooms_total`
--
DROP TABLE IF EXISTS `hotel_rooms_total`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hotel_rooms_total`  AS  select `hotel`.`hotel_id` AS `hotel_id`,`hotel`.`hotel_name` AS `hotel_name`,count(`rooms`.`room_no`) AS `total_rooms` from (`hotel` join `rooms` on((`hotel`.`hotel_id` = `rooms`.`hotel_id`))) group by `hotel`.`hotel_name` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD UNIQUE KEY `booking_id_UNIQUE` (`booking_id`),
  ADD KEY `fk_booking_type_hotel1_idx` (`hotel_id`),
  ADD KEY `fk_booking_room_type1_idx` (`room_type_id`),
  ADD KEY `fk_booking_booking_type1_idx` (`booking_type_id`),
  ADD KEY `fk_booking_guests1_idx` (`guest_id`);

--
-- Indexes for table `booking_type`
--
ALTER TABLE `booking_type`
  ADD PRIMARY KEY (`booking_type_id`),
  ADD UNIQUE KEY `booking_type_id_UNIQUE` (`booking_type_id`),
  ADD UNIQUE KEY `booking_type_UNIQUE` (`booking_type`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `country_id_UNIQUE` (`country_id`),
  ADD UNIQUE KEY `country_name_UNIQUE` (`country_name`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `employee_id_UNIQUE` (`employee_id`),
  ADD KEY `fk_employees_hotel1_idx` (`hotel_id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`guest_id`),
  ADD UNIQUE KEY `guest_id_UNIQUE` (`guest_id`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`),
  ADD UNIQUE KEY `hotel_id_UNIQUE` (`hotel_id`),
  ADD UNIQUE KEY `hotel_line1_UNIQUE` (`address_line1`),
  ADD KEY `fk_hotel_hotel_chains_idx` (`hotel_chain_id`),
  ADD KEY `fk_hotel_rating1_idx` (`hotel_rating`),
  ADD KEY `fk_hotel_countries1_idx` (`country_id`);

--
-- Indexes for table `hotel_chains`
--
ALTER TABLE `hotel_chains`
  ADD PRIMARY KEY (`hotel_chain_id`),
  ADD UNIQUE KEY `hotel_chain_id_UNIQUE` (`hotel_chain_id`),
  ADD UNIQUE KEY `hotel_chain_name_UNIQUE` (`hotel_chain_name`);

--
-- Indexes for table `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`period_id`),
  ADD UNIQUE KEY `discount_period_UNIQUE` (`discount_period`),
  ADD UNIQUE KEY `period_id_UNIQUE` (`period_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`hotel_rating`),
  ADD UNIQUE KEY `hotel_rating_UNIQUE` (`hotel_rating`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD KEY `fk_rooms_hotel1_idx` (`hotel_id`),
  ADD KEY `fk_rooms_room_type1_idx` (`room_type_id`);

--
-- Indexes for table `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`),
  ADD UNIQUE KEY `room_type_id_UNIQUE` (`room_type_id`);

--
-- Indexes for table `special_rates`
--
ALTER TABLE `special_rates`
  ADD KEY `fk_special_rates_room_type1_idx` (`room_type_id`),
  ADD KEY `fk_special_rates_periods1_idx` (`period_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `booking_type`
--
ALTER TABLE `booking_type`
  MODIFY `booking_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `guest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `hotel_chains`
--
ALTER TABLE `hotel_chains`
  MODIFY `hotel_chain_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `periods`
--
ALTER TABLE `periods`
  MODIFY `period_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_booking_booking_type1` FOREIGN KEY (`booking_type_id`) REFERENCES `booking_type` (`booking_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_booking_guests1` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_booking_room_type1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_booking_type_hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_employees_hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `fk_hotel_countries1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_hotel_hotel_chains` FOREIGN KEY (`hotel_chain_id`) REFERENCES `hotel_chains` (`hotel_chain_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_hotel_rating1` FOREIGN KEY (`hotel_rating`) REFERENCES `rating` (`hotel_rating`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_rooms_hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rooms_room_type1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `special_rates`
--
ALTER TABLE `special_rates`
  ADD CONSTRAINT `fk_special_rates_periods1` FOREIGN KEY (`period_id`) REFERENCES `periods` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_special_rates_room_type1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
