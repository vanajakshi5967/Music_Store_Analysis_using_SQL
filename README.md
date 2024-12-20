# Music Store Analysis
This project aims to analyze the sample database of a digital media store using SQL.

## Schema of the database
<img width="836" alt="Music_Store_Schema" src="https://github.com/user-attachments/assets/7e123289-24e7-4932-890f-e25f2058200f">

## Database and Tools Used
- PostgreSQL
- PgAdmin4

## Here's the list of Questions I solved
#### Set I Questions
1. Who is the senior most employee based on job title?
2. Which countries have the most invoices?
3. What are the top 3 values of total invoices?
4. Which city has the best customers? (We would like to throw a promotional Music Festival in the city where we made the most money.)
5. Who is the best customer? (The customer who has spent the most money will be declared the best customer.)

##### Set II Questions
1. Write a query to return the email, first name, last name, and genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.
2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.
3. Return all the track names that have a song length longer than the average song length. Return the name and milliseconds for each track. Order by the song length with the longest songs listed first.

##### Set III Questions
1. Find how much amount spent by each customer on artists? Write a query to return the customer name, artist name, and total spent.
2. We want to find out the most popular music genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top genre.
3. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount.

## Concepts I Used
* SQL Basics (SELECT, WHERE, and filtering)
* JOINS (INNER JOIN, LEFT JOIN)
* WINDOW Functions
* CTE
* GROUP BY, ORDER BY, and Aggregations

## Key Insights
- The majority of revenue comes from customers in the United States, followed by Canada and Brazil.
- Prague has the best customers who made the most money ($273.24).
- R Madhav is the best customer who has spent the most money ($144.54).
- Rock Music has the highest number of listeners (2635) over other music.

## Recommendations
- Invest in marketing campaigns targeting Rock and Metal genres, especially during peak seasons.
- Expand promotions in top-performing regions like the United States while exploring underperforming markets for growth opportunities.
- Evaluate customer feedback to identify potential new genres or features to attract a broader audience.

## Conclusion
The analysis of the database provided valuable insights into customer behavior, genre popularity, and revenue trends. The rock genre dominates sales, with the United States contributing the highest revenue. 
To capitalize on these insights, marketing efforts should prioritize top genres and regions, while exploring untapped markets for growth.






