/*
 Description: Create client_by_account_status by transforming  client model
*/


select account_status, count(*) as num_of_clients from {{ ref('client') }} group by account_status