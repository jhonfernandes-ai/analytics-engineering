/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__order_header_sales_reason
Camada.......: Staging
Origem.......: adventureworks.bronze.salesorderheadersalesreason

Descrição....:
Padroniza os dados da tabela SalesOrderHeaderSalesReason da camada Bronze.

Esta tabela representa o relacionamento entre pedidos de venda e seus
respectivos motivos.

Nesta etapa são realizadas apenas:
- padronização dos nomes das colunas para snake_case;
- organização visual do código.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Pedido
    SalesOrderID      as sales_order_id,

    --Motivo
    SalesReasonID     as sales_reason_id,

    -- Auditoria
    ModifiedDate      as modified_date

from {{ source('bronze', 'salesorderheadersalesreason') }}