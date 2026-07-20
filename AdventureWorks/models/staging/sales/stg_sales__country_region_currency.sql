/*
------------------------------------------------------------
Modelo......: stg_sales__country_region_currency
Camada......: Staging
Origem......: adventureworks.bronze.countryregioncurrency

Descrição...
Padroniza a relação entre países e moedas.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor.......: Jonathas Fernandes
Projeto.....: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    CountryRegionCode as country_region_code,
    CurrencyCode as currency_code,

    ModifiedDate as modified_date

from {{ source('bronze', 'countryregioncurrency') }}