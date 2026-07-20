/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__sales_reason
Camada.......: Staging
Origem.......: adventureworks.bronze.salesreason

Descrição....:
Padroniza os dados da tabela SalesReason da camada Bronze.

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

    -- Identificação do motivo da venda
    SalesReasonID          as sales_reason_id,

    -- Informações do motivo
    Name                   as sales_reason_name,
    ReasonType             as reason_type,

    -- Auditoria
    ModifiedDate           as modified_date

from {{ source('bronze', 'salesreason') }}