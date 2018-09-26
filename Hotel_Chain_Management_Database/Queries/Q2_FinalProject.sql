

-- How many available rooms are in a particular hotel for a given date?
USE hotelchain;				-- selecting database
DROP PROCEDURE IF EXISTS get_hotel_available_rooms;		-- dropping procedure if exists
DELIMITER //

CREATE PROCEDURE get_hotel_available_rooms			-- creating procedure
(
	hotel_name_param VARCHAR(45),
	date_param	DATE
)
BEGIN										-- starting query
SELECT hotel_name, total_rooms, SUM(booking_room_count) AS booked_rooms, (total_rooms - SUM(booking_room_count)) AS available_rooms		-- used SUM() function
FROM hotel_rooms_total JOIN booking						-- joined hotel_rooms_total view and booking table
		ON hotel_rooms_total.hotel_id = booking.hotel_id
WHERE date_param BETWEEN booked_from_date AND booked_to_date		-- condition
GROUP BY hotel_name
HAVING hotel_name = hotel_name_param;
END //
DELIMITER ;

CALL get_hotel_available_rooms('Radisson King', '2018-04-15');				-- calling procedure

