/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__order_detail
Camada.......: Staging
Origem.......: adventureworks.bronze.salesorderdetail

Descrição....:
Padroniza os dados da tabela SalesOrderDetail da camada Bronze.
Nesta etapa são realizadas apenas padronizações de nomenclatura e organização
das colunas. Nenhuma regra de negócio é aplicada.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação do pedido e item
    SalesOrderID            as sales_order_id,
    SalesOrderDetailID      as sales_order_detail_id,

    -- Rastreamento
    CarrierTrackingNumber   as carrier_tracking_number,

    -- Produto e promoção
    ProductID               as product_id,
    SpecialOfferID          as special_offer_id,

    -- Quantidade
    OrderQty                as order_quantity,

    -- Valores financeiros
    UnitPrice               as unit_price_amount,
    UnitPriceDiscount       as unit_price_discount_amount,
    LineTotal               as line_total_amount,

    -- Auditoria
    rowguid                 as row_guid,
    ModifiedDate            as modified_date

from {{ source('bronze', 'salesorderdetail') }}