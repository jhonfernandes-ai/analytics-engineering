/*
------------------------------------------------------------
Modelo......: stg_sales__sales_person
Camada......: Staging
Origem......: adventureworks.bronze.salesperson

Descrição...
Padroniza os dados da tabela SalesPerson da camada Bronze.

Esta tabela contém as informações dos vendedores da AdventureWorks,
incluindo metas, comissão, bônus e território de atuação.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor.......: Jonathas Fernandes
Projeto.....: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação
    BusinessEntityID as business_entity_id,

    -- Relacionamentos
    TerritoryID as territory_id,

    -- Metas e desempenho
    SalesQuota as sales_quota,
    Bonus as bonus_amount,
    CommissionPct as commission_percentage,
    SalesYTD as sales_ytd_amount,
    SalesLastYear as sales_last_year_amount,

    -- Auditoria
    rowguid as row_guid,
    ModifiedDate as modified_date

from {{ source('bronze', 'salesperson') }}