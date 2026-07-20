/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__special_offer_product
Camada.......: Staging
Origem.......: adventureworks.bronze.specialofferproduct

Descrição....:
Padroniza os dados da tabela SpecialOfferProduct da camada Bronze.

Esta tabela representa o relacionamento entre produtos e ofertas especiais.
Nenhuma regra de negócio é aplicada nesta etapa.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Chaves
    SpecialOfferID as special_offer_id,
    ProductID as product_id,

    -- Auditoria
    rowguid as row_guid,
    ModifiedDate as modified_date

from {{ source('bronze', 'specialofferproduct') }}