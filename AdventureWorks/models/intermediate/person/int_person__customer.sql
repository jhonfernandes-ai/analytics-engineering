/*
------------------------------------------------------------------------------
Modelo.......: int_person__customer
Camada.......: Intermediate
Origem.......:
    - stg_sales__customer
    - stg_person__person
    - stg_sales__store
    - stg_person__business_entity

Descrição....:
Consolida as informações dos clientes provenientes das tabelas de
staging, criando uma única entidade de negócio que servirá de base
para a dimensão de clientes.

Nesta etapa são aplicadas regras de negócio para:

- identificação do tipo de cliente;
- construção do nome completo da pessoa;
- definição do nome do cliente (pessoa ou loja);
- consolidação dos atributos principais.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

with customer as (

    select *
    from {{ ref('stg_sales__customer') }}

),

person as (

    select *
    from {{ ref('stg_person__person') }}

),

store as (

    select *
    from {{ ref('stg_sales__store') }}

),

business_entity as (

    select *
    from {{ ref('stg_person__business_entity') }}

)

select

    -- Identificação
    customer.customer_id,
    customer.business_entity_id,

    -- Relacionamentos
    customer.person_id,
    customer.store_id,
    customer.territory_id,

    -- Dados da pessoa
    person.person_type,

    concat_ws(
        ' ',
        person.first_name,
        person.middle_name,
        person.last_name
    ) as full_name,

    -- Dados da loja
    store.store_name,

    -- Tipo do cliente
    case
        when customer.person_id is not null then 'Individual'
        when customer.store_id is not null then 'Store'
        else 'Unknown'
    end as customer_type,

    -- Nome do cliente
    case
        when customer.person_id is not null then
            concat_ws(
                ' ',
                person.first_name,
                person.middle_name,
                person.last_name
            )

        when customer.store_id is not null then
            store.store_name

    end as customer_name,

    -- Auditoria
    business_entity.modified_date

from customer

left join person
    on customer.person_id = person.business_entity_id

left join store
    on customer.store_id = store.business_entity_id

left join business_entity
    on customer.business_entity_id = business_entity.business_entity_id