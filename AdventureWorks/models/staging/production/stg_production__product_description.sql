/*
------------------------------------------------------------------------------
Modelo.......: stg_production__product_description
Camada.......: Staging
Origem.......: adventureworks.bronze.productdescription

Descrição....:
Padroniza os dados da tabela ProductDescription da camada Bronze.

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

    -- Identificação da descrição
    ProductDescriptionID     as product_description_id,

    -- Descrição do produto
    Description              as product_description,

    -- Auditoria
    rowguid                  as row_guid,
    ModifiedDate             as modified_date

from {{ source('bronze', 'productdescription') }}