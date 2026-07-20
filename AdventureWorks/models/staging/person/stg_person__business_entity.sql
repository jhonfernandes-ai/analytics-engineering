/*
------------------------------------------------------------------------------
Modelo.......: stg_person__business_entity
Camada.......: Staging
Origem.......: adventureworks.bronze.businessentity

Descrição....:
Padroniza os dados da tabela BusinessEntity da camada Bronze.

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

    -- Identificação da entidade
    BusinessEntityID     as business_entity_id,

    -- Auditoria
    rowguid              as row_guid,
    ModifiedDate         as modified_date

from {{ source('bronze', 'businessentity') }}