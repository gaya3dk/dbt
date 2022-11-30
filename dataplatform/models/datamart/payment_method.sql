{% set payment_methods = ["bank_transfer", "credit_card", "debit_card"] %}

select
    payment_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
    {% endfor %}
    sum(amount) as total_amount
from {{ ref('payment') }}
group by 1