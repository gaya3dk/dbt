
/*
Description: Raw data of client as present in source database
*/

{{ config(materialized='table') }}

select * from raw.payment