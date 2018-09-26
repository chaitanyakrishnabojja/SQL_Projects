-- List all the hotels that have a URL available.

SELECT hotel_name, hotel_url
FROM hotel 
WHERE hotel_url IS NOT NULL;		-- hotel having url