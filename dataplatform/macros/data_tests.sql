{# Description: this test macro checks if a table is non-empty, test is considered passing when no row is returned from the query #}

{% test not_empty(model) %}
with validation as (
    select
    count(1) 
    as row_count
    from {{ model }}
)
select
    row_count
from validation
where row_count = 0

{% endtest %}
