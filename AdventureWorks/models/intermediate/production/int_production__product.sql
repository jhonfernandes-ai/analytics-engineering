{{ config(materialized='view') }}

with product as (

    select *
    from {{ ref('stg_production__product') }}

),

subcategory as (

    select *
    from {{ ref('stg_production__product_subcategory') }}

),

category as (

    select *
    from {{ ref('stg_production__product_category') }}

),

model as (

    select *
    from {{ ref('stg_production__product_model') }}

),

model_description as (

    select *
    from {{ ref('stg_production__product_model_product_description_culture') }}
    where trim(culture_id) = 'en'

),

description as (

    select *
    from {{ ref('stg_production__product_description') }}

)

select

    -- Produto
    p.*,

    -- Subcategoria
    s.product_subcategory_name,

    -- Categoria
    c.product_category_name,

    -- Modelo
    m.product_model_name,

    -- Descrição
    d.product_description_id,
    d.product_description

from product p

left join subcategory s
    on p.product_subcategory_id = s.product_subcategory_id

left join category c
    on s.product_category_id = c.product_category_id

left join model m
    on p.product_model_id = m.product_model_id

left join model_description md
    on p.product_model_id = md.product_model_id

left join description d
    on md.product_description_id = d.product_description_id