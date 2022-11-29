
select 
    account_status, count(*) as clients_by_status
from {{ ref('client') }} 
group by account_status