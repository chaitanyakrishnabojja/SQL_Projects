-- List all the unique countries hotels are located in.



SELECT DISTINCT country_name						-- used distinct keyword
FROM hotel JOIN countries
		ON hotel.country_id = countries.country_id;