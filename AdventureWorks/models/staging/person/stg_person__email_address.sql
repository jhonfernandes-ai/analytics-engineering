/*
------------------------------------------------------------------------------
Modelo.......: stg_person__email_address
Camada.......: Staging
Origem.......: adventureworks.bronze.emailaddress

Descrição....:
Padroniza os dados da tabela EmailAddress da camada Bronze.

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

    -- Identificação do e-mail
    EmailAddressID           as email_address_id,

    -- Informações de contato
    EmailAddress             as email_address,

    -- Auditoria
    rowguid                  as row_guid,
    ModifiedDate             as modified_date

from {{ source('bronze', 'emailaddress') }}