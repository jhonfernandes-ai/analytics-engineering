/*
------------------------------------------------------------------------------
Modelo.......: stg_person__person
Camada.......: Staging
Origem.......: adventureworks.bronze.person

Descrição....:
Padroniza os dados da tabela Person da camada Bronze.

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

    -- Identificação da pessoa
    BusinessEntityID           as business_entity_id,

    -- Classificação
    PersonType                 as person_type,
    NameStyle                  as name_style,

    -- Nome
    Title                      as title,
    FirstName                  as first_name,
    MiddleName                 as middle_name,
    LastName                   as last_name,
    Suffix                     as suffix,

    -- Configuração
    EmailPromotion             as email_promotion,

    -- Informações adicionais
    AdditionalContactInfo      as additional_contact_info,
    Demographics               as demographics,

    -- Auditoria
    rowguid                    as row_guid,
    ModifiedDate               as modified_date

from {{ source('bronze', 'person') }}