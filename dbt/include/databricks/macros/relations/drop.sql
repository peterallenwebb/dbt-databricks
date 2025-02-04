{% macro databricks__drop_relation(relation) -%}
    {% call statement('drop_relation', auto_begin=False) -%}
        {{ get_drop_sql(relation) }}
    {%- endcall %}
{% endmacro %}

{% macro databricks__get_drop_sql(relation) -%}
    {%- if relation.is_materialized_view -%}
        {{ drop_materialized_view(relation) }}
    {%- elif relation.is_streaming_table-%}
        {{ drop_streaming_table(relation) }}   
    {%- elif relation.is_view -%}
        {{ drop_view(relation) }}
    {%- else -%}
        {{ drop_table(relation) }}
    {%- endif -%}
{% endmacro %}
