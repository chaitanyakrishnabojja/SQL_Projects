-- How many books has a customer made in one year?
USE hotelchain;				-- selecting database
DROP PROCEDURE IF EXISTS customer_booking_count_year;		-- dropping procedure if exists
DELIMITER //
CREATE PROCEDURE customer_booking_count_year				-- creating procedure
(
	guest_name_param	VARCHAR(45),
    year_param		DATE
)
BEGIN
SELECT guest_name, COUNT(booking_id) AS no_of_bookings					-- used COUNT() function
FROM guests JOIN booking												-- joined guests and booking tables
		ON guests.guest_id = booking.guest_id
WHERE (YEAR(booked_from_date) = year_param) OR (YEAR(booked_to_date) = year_param)		-- filtering bookings in year 2018
GROUP BY guest_name
HAVING guest_name = guest_name_param;
END //
DELIMITER ;

CALL customer_booking_count_year('Pollard', '2018');			-- calling procedure

