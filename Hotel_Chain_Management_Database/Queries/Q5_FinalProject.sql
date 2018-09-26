
-- How many rooms are booked in a particular hotel on a given date?

USE hotelchain;
DROP PROCEDURE IF EXISTS rooms_booked_hotel_date;
DELIMITER //
CREATE PROCEDURE rooms_booked_hotel_date
(
	hotel_name_param	VARCHAR(45),
    date_param	DATE
)
BEGIN
SELECT hotel_name, COUNT(booking_room_count) AS rooms_booked			-- used count() function
FROM hotel JOIN booking													-- joined hotel and booking
		ON hotel.hotel_id = booking.hotel_id
WHERE date_param BETWEEN booked_from_date AND booked_to_date			-- applying condition by date
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END //
DELIMITER ;

CALL rooms_booked_hotel_date('Radisson King', '2018-04-16');