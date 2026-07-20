/*
------------------------------------------------------------------------------
Modelo.......: stg_person__address
Camada.......: Staging
Origem.......: adventureworks.bronze.address

Descrição....:
Padroniza os dados da tabela Address da camada Bronze.

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

    -- Identificação do endereço
    AddressID               as address_id,

    -- Informações do endereço
    AddressLine1            as address_line_1,
    AddressLine2            as address_line_2,
    City                    as city,
    StateProvinceID         as state_province_id,
    PostalCode              as postal_code,
    SpatialLocation         as spatial_location,

    -- Auditoria
    rowguid                 as row_guid,
    ModifiedDate            as modified_date

from {{ source('bronze', 'address') }}