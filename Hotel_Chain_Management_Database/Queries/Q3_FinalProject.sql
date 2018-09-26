-- How many hotels are in a hotel chain?

SELECT hotel_chain_name, COUNT(hotel_id)				-- used count() function to get count of hotels
FROM hotel_chains JOIN hotel							-- joining hotel_chains and hotel
		ON hotel_chains.hotel_chain_id = hotel.hotel_chain_id
GROUP BY hotel.hotel_chain_id							-- grouped by hotel_chain_id