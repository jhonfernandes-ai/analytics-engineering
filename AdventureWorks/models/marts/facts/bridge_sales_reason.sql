/*
------------------------------------------------------------------------------
Modelo.......: bridge_sales_reason
Descrição....: Tabela Ponte (Bridge) para resolver o relacionamento N:M 
               entre Pedidos e Motivos de Venda.
Granularidade: 1 registro por Motivo associado a um Pedido.
------------------------------------------------------------------------------
*/

{{ config(
    materialized='table',
    cluster_by=['sales_order_id']
) }}

with order_reason as (

    select *
    from {{ ref('stg_sales__order_header_sales_reason') }}

),

reason_detail as (

    select *
    from {{ ref('stg_sales__sales_reason') }}

)

select
    -- Chaves
    or_head.sales_order_id,
    or_head.sales_reason_id,

    -- Descritivos do Motivo (com alias para padronizar o nome do campo)
    rd.sales_reason_name as reason_name,
    rd.reason_type

from order_reason as or_head
left join reason_detail as rd
    on or_head.sales_reason_id = rd.sales_reason_id