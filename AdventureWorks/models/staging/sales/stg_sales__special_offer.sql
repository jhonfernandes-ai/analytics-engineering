/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__special_offer
Camada.......: Staging
Origem.......: adventureworks.bronze.specialoffer

Descrição....:
Padroniza os dados da tabela SpecialOffer da camada Bronze.

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

    -- Identificação da oferta
    SpecialOfferID          as special_offer_id,

    -- Informações da oferta
    Description             as description,
    DiscountPct             as discount_pct,
    Type                    as offer_type,
    Category                as offer_category,

    -- Vigência
    StartDate               as start_date,
    EndDate                 as end_date,

    -- Regras da oferta
    MinQty                  as min_qty,
    MaxQty                  as max_qty,

    -- Auditoria
    rowguid                 as row_guid,
    ModifiedDate            as modified_date

from {{ source('bronze', 'specialoffer') }}