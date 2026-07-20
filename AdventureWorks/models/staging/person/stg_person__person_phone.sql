/*
------------------------------------------------------------------------------
Modelo.......: stg_person__person_phone
Camada.......: Staging
Origem.......: adventureworks.bronze.personphone

Descrição....:
Padroniza os dados da tabela PersonPhone da camada Bronze.

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
    BusinessEntityID         as business_entity_id,

    -- Informações de contato
    PhoneNumber              as phone_number,
    PhoneNumberTypeID        as phone_number_type_id,

    -- Auditoria
    ModifiedDate             as modified_date

from {{ source('bronze', 'personphone') }}