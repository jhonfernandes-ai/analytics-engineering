/*
------------------------------------------------------------------------------
Modelo.......: stg_production__product_subcategory
Camada.......: Staging
Origem.......: adventureworks.bronze.productsubcategory

Descrição....:
Padroniza os dados da tabela ProductSubcategory da camada Bronze.

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

    -- Identificação da subcategoria
    ProductSubcategoryID     as product_subcategory_id,

    -- Relacionamento
    ProductCategoryID        as product_category_id,

    -- Descrição
    Name                     as product_subcategory_name,

    -- Auditoria
    rowguid                  as row_guid,
    ModifiedDate             as modified_date

from {{ source('bronze', 'productsubcategory') }}