/*
------------------------------------------------------------
Modelo......: stg_sales__credit_card
Camada......: Staging
Origem......: adventureworks.bronze.creditcard

Descrição...
Padroniza os dados da tabela CreditCard da camada Bronze.

Esta tabela contém as informações dos cartões de crédito
utilizados nos pedidos de venda.

Nenhuma regra de negócio é aplicada nesta etapa.

Autor.......: Jonathas Fernandes
Projeto.....: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação
    CreditCardID as credit_card_id,

    -- Informações do cartão
    CardType as card_type,
    CardNumber as card_number,
    ExpMonth as expiration_month,
    ExpYear as expiration_year,

    -- Auditoria
    ModifiedDate as modified_date

from {{ source('bronze', 'creditcard') }}