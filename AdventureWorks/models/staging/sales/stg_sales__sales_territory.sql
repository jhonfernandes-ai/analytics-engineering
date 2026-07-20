/*
------------------------------------------------------------
Modelo......: stg_sales__sales_territory
Camada......: Staging
Origem......: adventureworks.bronze.salesterritory

Descrição...
Padroniza os dados da tabela SalesTerritory da camada Bronze.

Esta tabela contém as informações dos territórios de vendas,
incluindo país, grupo geográfico e indicadores de desempenho.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor.......: Jonathas Fernandes
Projeto.....: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação
    TerritoryID as territory_id,

    -- Informações do território
    Name as territory_name,
    CountryRegionCode as country_region_code,
    `group` as territory_group,

    -- Indicadores
    SalesYTD as sales_ytd_amount,
    SalesLastYear as sales_last_year_amount,
    CostYTD as cost_ytd_amount,
    CostLastYear as cost_last_year_amount,

    -- Auditoria
    rowguid as row_guid,
    ModifiedDate as modified_date

from {{ source('bronze', 'salesterritory') }}