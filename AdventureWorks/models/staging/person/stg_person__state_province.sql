/*
------------------------------------------------------------------------------
Modelo.......: stg_person__state_province
Camada.......: Staging
Origem.......: adventureworks.bronze.stateprovince

Descrição....:
Padroniza os dados da tabela StateProvince da camada Bronze.

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

    -- Identificação do estado/província
    StateProvinceID            as state_province_id,

    -- Informações geográficas
    StateProvinceCode          as state_province_code,
    CountryRegionCode          as country_region_code,
    IsOnlyStateProvinceFlag    as is_only_state_province_flag,
    Name                       as state_province_name,

    -- Território de vendas
    TerritoryID                as territory_id,

    -- Auditoria
    rowguid                    as row_guid,
    ModifiedDate               as modified_date

from {{ source('bronze', 'stateprovince') }}