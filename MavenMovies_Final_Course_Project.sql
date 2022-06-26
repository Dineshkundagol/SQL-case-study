/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

use mavenmovies;

select store.store_id, staff.first_name, staff.last_name, staff.email, city.city, country.country, address.address
 from store left join staff on staff.staff_id= store.manager_staff_id 
			left join city on city.city_id=staff.address_id 
            left join country on city.country_id = country.country_id
            left join address on address.city_id= city.city_id;







	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

select inventory_id, store_id, title, rating, rental_rate, replacement_cost
from inventory join film on film.film_id= inventory.film_id;


/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

select  rating, store_id,  count(inventory_id)
from inventory join film on film.film_id= inventory.film_id
group by rating, store_id
order by rating;


/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

select store_id,category_id, avg(replacement_cost), sum(replacement_cost)
from inventory join film on film.film_id= inventory.film_id
				join film_category on film.film_id= film_category.film_id
group by store_id, category_id;



/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

select customer_id, concat(first_name, " ", last_name) as name, store_id,active, address, city, district, country  
from customer left join address on customer.address_id= address.address_id
				join city on address.city_id=city.city_id
                join country on city.country_id=country.country_id;


/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

select customer.customer_id, concat(customer.first_name, " ", customer.last_name) as name,
		sum(payment.amount) as total
from customer right join payment on customer.customer_id= payment.customer_id
group by payment.customer_id
order by total desc;

    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

select 	distinct concat(advisor.first_name, " ", advisor.last_name) as advisor_name,
		concat(investor.first_name, " ", investor.last_name) as investor_name, company_name 
from investor, advisor;
    

/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

with cte1 as (select count(*) as number_of_actors, case when awards="Emmy, Oscar, Tony " then 3
		when awards in ("Emmy, Oscar", "Emmy, Tony","Oscar, Tony") then 2
        else 1
        end as number_of_awards from actor_award
        group by number_of_awards),
   cte2 as (select count(*) as total from actor_award)
   select cte1.number_of_actors/cte2.total as percentage, cte1.number_of_awards from cte1,cte2;
