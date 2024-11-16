/* SET-I Questions */

-- Q1: Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;
-- "Madan Mohan is the senior employee."

-- Q2: Which countries have the most invoices?
SELECT billing_country,
	COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;
-- "The USA has the most invoices of 131, followed by other countries like Canada, Brazil, and so on."

-- Q3: What are the top 3 values of total Invoice?
SELECT ROUND(CAST(total AS NUMERIC), 2)
FROM invoice
ORDER BY total DESC
LIMIT 3;
-- "The top 3 values of Total Invoices are 23.76, 19.8, & 19.8."

/* Q3: Which city has the best customers? We would like to throw a promotional 
 Music Festival in the city we made the most money. Write a query that returns 
 one city that has the highest sum of invoice totals. Return both the city name 
 and the sum of all invoice totals.
*/
SELECT 
	billing_city,
	ROUND(CAST(SUM(total) AS NUMERIC), 2) AS total
FROM invoice
GROUP BY billing_city
ORDER BY total DESC
LIMIT 1;
-- "Prague has made the most money ($273.24). You can conduct a promotional Music Festival in Prague."


/* Q5: Who is the best customer? The customer who has spent the most money will be declared 
	the best customer. Write a query that returns the person who has spent the most money.
*/
SELECT 
	invoice.customer_id,
	customer.first_name,
	customer.last_name,
	ROUND(CAST(SUM(total) AS NUMERIC), 2) AS total
FROM invoice
LEFT JOIN customer -- you can use "INNER JOIN" as well
	ON invoice.customer_id = customer.customer_id
GROUP BY 1, 2, 3
ORDER BY total DESC
LIMIT 1;
-- "R Madhav has spent the most money ($144.54)."

/* SET-II Questions */

/* Q1: Write a query to return the email, first name, last name, and genre of all Rock Music listeners. 
	 Return your list ordered alphabetically by email starting with A.
*/
SELECT 
	customer.first_name,
	customer.last_name,
	customer.email,
	genre.name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE 
	genre.name = 'Rock'
GROUP BY 1, 2, 3, 4
ORDER BY email;


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. 
*/
SELECT 
	artist.name,
	COUNT(track.*) AS total_track_count
FROM artist
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
WHERE 
	track.genre_id = '1'  -- "Rock" has the genre_id of 1
GROUP BY artist.name
ORDER BY total_track_count DESC
LIMIT 10;


/*Q3: Return all the track names that have a song length longer than the average song length. 
Return the name and milliseconds for each track. Order by the song length with the longest songs listed first.
*/
SELECT 
	name,
	milliseconds
FROM track
WHERE
	milliseconds > (SELECT AVG(milliseconds) FROM track)
GROUP BY 	
	1, 2
ORDER BY milliseconds DESC;


/* SET-III Questions */

/* Q1: Find how much amount spent by each customer on artists? 
	Write a query to return customer name, artist name, and total spent.
*/
SELECT 
	customer.customer_id AS cust_id,
	customer.first_name AS cust_first_name,
	customer.last_name AS cust_last_name,
	artist.name AS artist_name,
	ROUND(CAST(SUM(invoice_line.unit_price * invoice_line.quantity) AS NUMERIC), 2) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY 
	cust_id,
	cust_first_name,
	cust_last_name,
	artist_name
ORDER BY 
	cust_id,
	total_spent DESC;


/* Q2: We want to find out the most popular music genre for each country. 
	We determine the most popular genre as the genre with the highest amount of purchases. 
	Write a query that returns each country along with the top genre. 
	For countries where the maximum number of purchases is shared return all genres.
*/

WITH top_purchases AS (
	SELECT
		invoice.billing_country,
		genre.name genre_name,
		COUNT(invoice_line.quantity) AS no_of_purchases,
		ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY COUNT(invoice_line.quantity) DESC) AS rn
	FROM invoice
	JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
	JOIN track ON invoice_line.track_id = track.track_id
	JOIN genre ON track.genre_id = genre.genre_id
	GROUP BY 1, 2
	)
SELECT 
	billing_country,
	genre_name,
	no_of_purchases
FROM top_purchases
WHERE
	rn = 1;


/*Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.
*/
WITH top_customers AS (
	SELECT 
		invoice.billing_country country,
		customer.first_name first_name,
		customer.last_name last_name,
		ROUND(CAST(SUM(invoice.total) AS NUMERIC), 2) AS total_spent,
		ROW_NUMBER() OVER(PARTITION BY invoice.billing_country
							ORDER BY SUM(invoice.total) DESC) AS rn
	FROM invoice
	LEFT JOIN customer ON invoice.customer_id = customer.customer_id
	GROUP BY 1, 2, 3)
SELECT *
FROM top_customers
WHERE rn = 1;














