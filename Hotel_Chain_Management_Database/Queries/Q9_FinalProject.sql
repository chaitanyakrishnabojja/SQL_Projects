
-- List the rate for a room at a given time during the year.

SELECT room_type, discount_period, room_cost
FROM room_type JOIN special_rates									-- joining 3 tables
		ON room_type.room_type_id = special_rates.room_type_id
      JOIN periods
      	ON special_rates.period_id = periods.period_id
WHERE discount_period = 'Jan - Feb';
		
		


