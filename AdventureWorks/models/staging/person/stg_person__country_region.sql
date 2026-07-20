/*
------------------------------------------------------------------------------
Modelo.......: stg_person__country_region
Camada.......: Staging
Origem.......: adventureworks.bronze.countryregion

Descrição....:
Padroniza os dados da tabela CountryRegion da camada Bronze.

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

    -- Identificação do país/região
    CountryRegionCode       as country_region_code,

    -- Informações do país/região
    Name                    as country_region_name,

    -- Auditoria
    ModifiedDate            as modified_date

from {{ source('bronze', 'countryregion') }}