use mavenmovies;

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 


select 	staff_id,
		first_name,
        last_name,
        email,
        store_id
from staff;



/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

select 	store_id as store,
		count(inventory_id) as "number of inventory items at a store"
from inventory
group by store_id;





/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

select 	store_id,
		count(active) as "number of active customers"
from customer
where active=1
group by store_id;






/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/


select count(email) as "total customer email adresses"
from customer;



/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

select inventory.store_id as store,
count(distinct inventory.film_id) as "number of films per store",
count( distinct film_category.category_id) as "number of film category per store"
from inventory inner join film_category on inventory.film_id=film_category.film_id
group by store_id; 




/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/
select
	min(replacement_cost) as "minimum replacement cost",
    max(replacement_cost) as "maximum replacement cost",
    avg(replacement_cost) as "average replacement cost"
from film;






/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

select 	avg(amount) as "average payment processed per transaction",
		max(amount) as "maximum payment processed per transaction"
from payment; 



/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

select 	count(rental_date) as "total number of rental taken by customer",
		customer_id		
from rental
group by customer_id order by count(rental_date) desc ; 

