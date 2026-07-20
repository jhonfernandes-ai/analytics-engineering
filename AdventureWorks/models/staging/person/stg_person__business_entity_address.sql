/*
------------------------------------------------------------------------------
Modelo.......: stg_person__business_entity_address
Camada.......: Staging
Origem.......: adventureworks.bronze.businessentityaddress

Descrição....:
Padroniza os dados da tabela BusinessEntityAddress da camada Bronze.

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

    -- Relacionamentos
    BusinessEntityID        as business_entity_id,
    AddressID               as address_id,
    AddressTypeID           as address_type_id,

    -- Auditoria
    rowguid                 as row_guid,
    ModifiedDate            as modified_date

from {{ source('bronze', 'businessentityaddress') }}