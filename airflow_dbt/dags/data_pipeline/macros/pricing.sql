{% macro discounted_amount(extended_price, discount_percentage) %}
    ({{ extended_price }} * {{ discount_percentage }})
{% endmacro %}