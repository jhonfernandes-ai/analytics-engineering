/*
------------------------------------------------------------------------------
Modelo.......: stg_person__address_type
Camada.......: Staging
Origem.......: adventureworks.bronze.addresstype

Descrição....:
Padroniza os dados da tabela AddressType da camada Bronze.

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

    -- Identificação do tipo de endereço
    AddressTypeID          as address_type_id,

    -- Descrição
    Name                   as address_type_name,

    -- Auditoria
    rowguid                as row_guid,
    ModifiedDate           as modified_date

from {{ source('bronze', 'addresstype') }}