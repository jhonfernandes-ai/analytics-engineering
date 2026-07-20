/*
------------------------------------------------------------
Modelo......: stg_sales__currency_rate
Camada......: Staging
Origem......: adventureworks.bronze.currencyrate

Descrição...
Padroniza os dados das taxas de conversão de moedas.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor.......: Jonathas Fernandes
Projeto.....: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação
    CurrencyRateID as currency_rate_id,

    -- Datas
    CurrencyRateDate as currency_rate_date,

    -- Moedas
    FromCurrencyCode as from_currency_code,
    ToCurrencyCode as to_currency_code,

    -- Taxas
    AverageRate as average_rate,
    EndOfDayRate as end_of_day_rate,

    -- Auditoria
    ModifiedDate as modified_date

from {{ source('bronze', 'currencyrate') }}