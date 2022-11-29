
select year(pt.payment_date) as year, 
    pt.currency, 
    count(pt.payee_client_id) as volume, 
    sum(pt.amount) as value 
from {{ ref('client') }} ct 
join {{ ref('payment') }} pt 
on ct.client_id = pt.payee_client_id 
group by year, pt.currency