-- How many distinct guest have made bookings for a particular month?
USE hotelchain;				-- selecting database
DROP PROCEDURE IF EXISTS guests_count_month;		-- dropping procedure
DELIMITER //
CREATE PROCEDURE guests_count_month					-- creating procedure
(
	month_param	INT
)
BEGIN
SELECT COUNT(DISTINCT booking.guest_id)	AS customers_count_month					-- used count function and distinct keyword
FROM guests JOIN booking									-- joining guests and booking
		ON guests.guest_id = booking.guest_id
WHERE (MONTH(booked_from_date)) = month_param OR (MONTH(booked_to_date) = month_param);
END //
DELIMITER ;

CALL guests_count_month(4);						-- calling procedure
