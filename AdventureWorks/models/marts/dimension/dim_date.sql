{{ config(
    materialized='table',
    file_format='delta'
) }}

with date_range as (
    select explode(
        sequence(
            to_date('2000-01-01'), 
            to_date('2030-12-31'), 
            interval 1 day
        )
    ) as date_day
)

select
    -- Chave Primária Numérica (Surrogate Key) no formato YYYYMMDD (ex: 20240101)
    cast(date_format(date_day, 'yyyyMMdd') as int) as date_sk,
    
    -- Atributos Principais de Data
    date_day,
    year(date_day) as year,
    quarter(date_day) as quarter,
    month(date_day) as month,
    date_format(date_day, 'MMMM') as month_name,
    date_format(date_day, 'MMM') as month_name_short,
    day(date_day) as day_of_month,
    dayofweek(date_day) as day_of_week,
    date_format(date_day, 'EEEE') as day_name,
    
    -- Colunas Auxiliares Úteis para Filtros no Power BI
    case when dayofweek(date_day) in (1, 7) then true else false end as is_weekend,
    last_day(date_day) as end_of_month,
    date_trunc('quarter', date_day) as start_of_quarter,
    date_trunc('year', date_day) as start_of_year

from date_range