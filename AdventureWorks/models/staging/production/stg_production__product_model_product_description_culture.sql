/*
------------------------------------------------------------------------------
Modelo.......: stg_production__product_model_product_description_culture
Camada.......: Staging
Origem.......: adventureworks.bronze.productmodelproductdescriptionculture

Descrição....:
Padroniza os dados da tabela ProductModelProductDescriptionCulture da camada Bronze.

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
    ProductModelID             as product_model_id,
    ProductDescriptionID       as product_description_id,
    CultureID                  as culture_id,

    -- Auditoria
    ModifiedDate               as modified_date

from {{ source('bronze', 'productmodelproductdescriptionculture') }}