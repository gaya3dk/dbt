
{{ config(materialized='table') }}

select * from raw.payment