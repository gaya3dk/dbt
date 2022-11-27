/*
 Description: Value and Volume of payments by year 
*/

select year(pt.payment_date) as month, pt.currency, count(pt.payee_client_id) as volume, sum(pt.amount) as value 
from {{ ref('client') }} ct 
join {{ ref('payment') }} pt on ct.client_id = pt.payee_client_id 
group by month, pt.currency