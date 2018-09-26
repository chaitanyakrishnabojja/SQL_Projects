-- How many rooms are available in a given hotel?
USE hotelchain;		-- selecting database
DROP PROCEDURE IF EXISTS hotel_rooms_available;		-- dropping procedure
DELIMITER //
CREATE PROCEDURE hotel_rooms_available				-- creating procedure
(
	hotel_name_param	VARCHAR(45),
    today	DATE
)
BEGIN
SELECT hotel_name, total_rooms, SUM(booking_room_count) AS booked_rooms, (total_rooms - SUM(booking_room_count)) AS available_rooms		-- used SUM() function
FROM hotel_rooms_total JOIN booking						-- joined hotel_rooms_total view and booking table
		ON hotel_rooms_total.hotel_id = booking.hotel_id
WHERE today BETWEEN booked_from_date AND booked_to_date		-- condition
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END //
DELIMITER ;

CALL hotel_rooms_available('Radisson King', '2018-04-15');		-- calling procedure