/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__currency
Camada.......: Staging
Origem.......: adventureworks.bronze.currency

Descrição....:
Padroniza os dados da tabela Currency da camada Bronze.

Esta tabela contém o cadastro das moedas utilizadas pelo AdventureWorks.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação da moeda
    CurrencyCode as currency_code,

    -- Informações da moeda
    Name as currency_name,

    -- Auditoria
    ModifiedDate as modified_date

from {{ source('bronze', 'currency') }}