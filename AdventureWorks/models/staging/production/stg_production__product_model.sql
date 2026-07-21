/*
------------------------------------------------------------------------------
Modelo.......: stg_production__product_model
Camada.......: Staging
Origem.......: adventureworks.bronze.productmodel

Descrição....:
Padroniza os dados da tabela ProductModel da camada Bronze.

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

    -- Identificação do modelo
    ProductModelID            as product_model_id,

    -- Informações do modelo
    Name                      as product_model_name,
    CatalogDescription        as catalog_description,
    Instructions              as instructions,

    -- Auditoria
    rowguid                   as row_guid,
    ModifiedDate              as modified_date

from {{ source('bronze', 'productmodel') }}