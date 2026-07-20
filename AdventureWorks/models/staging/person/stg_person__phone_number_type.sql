/*
------------------------------------------------------------------------------
Modelo.......: stg_person__phone_number_type
Camada.......: Staging
Origem.......: adventureworks.bronze.phonenumbertype

Descrição....:
Padroniza os dados da tabela PhoneNumberType da camada Bronze.

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

    -- Identificação do tipo de telefone
    PhoneNumberTypeID        as phone_number_type_id,

    -- Descrição
    Name                     as phone_number_type_name,

    -- Auditoria
    ModifiedDate             as modified_date

from {{ source('bronze', 'phonenumbertype') }}