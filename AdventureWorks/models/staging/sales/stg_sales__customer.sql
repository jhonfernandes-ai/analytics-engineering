/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__customer
Camada.......: Staging
Origem.......: adventureworks.bronze.customer

Descrição....:
Padroniza os dados da tabela Customer da camada Bronze.
Nesta etapa são realizadas apenas padronizações de nomenclatura
utilizando snake_case. Nenhuma regra de negócio é aplicada.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação do cliente
    CustomerID          as customer_id,
    PersonID            as person_id,
    StoreID             as store_id,
    TerritoryID         as territory_id,

    -- Informações do cliente
    AccountNumber       as account_number,

    -- Auditoria
    rowguid             as row_guid,
    ModifiedDate        as modified_date

from {{ source('bronze', 'customer') }}