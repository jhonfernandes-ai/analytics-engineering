/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__store
Camada.......: Staging
Origem.......: adventureworks.bronze.store

Descrição....:
Padroniza os dados da tabela Store da camada Bronze.

Esta tabela contém o cadastro das lojas (revendedores), incluindo o vendedor
responsável e informações demográficas.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação da loja
    BusinessEntityID as business_entity_id,

    -- Informações da loja
    Name as store_name,
    SalesPersonID as sales_person_id,
    Demographics as demographics,

    -- Auditoria
    rowguid as row_guid,
    ModifiedDate as modified_date

from {{ source('bronze', 'store') }}