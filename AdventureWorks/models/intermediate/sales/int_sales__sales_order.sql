/*
------------------------------------------------------------------------------
Modelo.......: int_sales__sales_order

Descrição....:
Consolida as informações operacionais das vendas na granularidade
de um item por pedido.

Granularidade:
1 registro por item de pedido (SalesOrderDetail).

------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

with order_detail as (

    select *
    from {{ ref('stg_sales__order_detail') }}

),

order_header as (

    select *
    from {{ ref('stg_sales__order_header') }}

),

customer as (

    select *
    from {{ ref('stg_sales__customer') }}

),

territory as (

    select *
    from {{ ref('stg_sales__sales_territory') }}

),

sales_person as (

    select *
    from {{ ref('stg_sales__sales_person') }}

),

special_offer as (

    select *
    from {{ ref('stg_sales__special_offer') }}

),

credit_card as (

    select *
    from {{ ref('stg_sales__credit_card') }}

)

select

    -- Identificação

    od.sales_order_id,
    od.sales_order_detail_id,

    -- Produto

    od.product_id,
    od.special_offer_id,
    od.carrier_tracking_number,

    -- Cliente

    oh.customer_id,
    c.account_number,

    -- Pedido

    oh.sales_order_number,
    oh.order_date,
    oh.due_date,
    oh.ship_date,

    oh.status,
    oh.online_order_flag,

    -- Quantidades

    od.order_quantity,

    -- Valores do Item

    od.unit_price_amount,
    od.unit_price_discount_amount,
    od.line_total_amount,

    -- Valores do Pedido

    oh.subtotal_amount,
    oh.tax_amount,
    oh.freight_amount,
    oh.total_due_amount,

    -- Território

    oh.territory_id,
    t.territory_name,
    t.territory_group,
    t.country_region_code,

    -- Vendedor


    oh.sales_person_id,

    sp.sales_quota,
    sp.bonus_amount,
    sp.commission_percentage,

    -- Oferta

    so.description           as special_offer_description,
    so.discount_pct,
    so.offer_type,
    so.offer_category,

    -- Pagamento
    
    oh.credit_card_id,
    cc.card_type,

    -- Auditoria

    od.modified_date

from order_detail od

left join order_header oh
    on od.sales_order_id = oh.sales_order_id

left join customer c
    on oh.customer_id = c.customer_id

left join territory t
    on oh.territory_id = t.territory_id

left join sales_person sp
    on oh.sales_person_id = sp.business_entity_id

left join special_offer so
    on od.special_offer_id = so.special_offer_id

left join credit_card cc
    on oh.credit_card_id = cc.credit_card_id