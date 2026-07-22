/*
------------------------------------------------------------------------------
Modelo.......: fact_sales
Camada.......: Gold / Marts
Origem.......: int_sales__sales_order

Descrição....:
Tabela Fato de Vendas na granularidade de item de pedido.
Consolida métricas financeiras, quantitativas e chaves para dimensões.

Granularidade: 1 registro por item de pedido (sales_order_detail_id).
------------------------------------------------------------------------------
*/

{{ config(
    materialized='table',
    file_format='delta',
    liquid_clustered_by=['order_date', 'customer_id']
) }}

{{ config(materialized='table') }}

with int_sales as (

    select *
    from {{ ref('int_sales__sales_order') }}

)

select
    -- Identificação e Chave Primária
    sales_order_detail_id,
    sales_order_id,

    -- Chaves Estrangeiras (FKs para Star Schema)
    product_id,
    customer_id,
    credit_card_id,
    territory_id,
    sales_person_id,
    special_offer_id,

    -- Atributos do Pedido
    sales_order_number,
    status,
    online_order_flag,
    card_type,

    -- Datas (Dimensão Tempo)
    order_date,
    due_date,
    ship_date,

    -- Métricas Quantitativas
    order_quantity,

    -- Métricas Financeiras
    unit_price_amount,
    unit_price_discount_amount,
    line_total_amount as net_amount,

    -- Calculados de Receita e Desconto
    (order_quantity * unit_price_amount) as gross_amount,
    (order_quantity * unit_price_amount * unit_price_discount_amount) as total_discount_amount,

    -- Valores do Cabeçalho do Pedido (Frete e Impostos)
    subtotal_amount,
    tax_amount,
    freight_amount,
    total_due_amount

from int_sales