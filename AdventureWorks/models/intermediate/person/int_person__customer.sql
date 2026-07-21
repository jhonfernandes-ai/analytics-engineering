/*
------------------------------------------------------------------------------
Modelo.......: int_person__customer

Descrição....:
Consolida informações de clientes do AdventureWorks, unificando
clientes pessoa física e clientes corporativos.

Enriquece os dados com:

- Pessoa
- Loja
- Endereço
- Estado
- País

Granularidade:
1 registro por customer.

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

person_address as (

    select *
    from {{ ref('stg_person__business_entity_address') }}

    where address_type_id = 2

),

store_address as (

    select *
    from {{ ref('stg_person__business_entity_address') }}

    where address_type_id = 3

),

address as (

    select *
    from {{ ref('stg_person__address') }}

),

state_province as (

    select *
    from {{ ref('stg_person__state_province') }}

),

country_region as (

    select *
    from {{ ref('stg_person__country_region') }}

)

select

    -- Customer
    c.customer_id,
    c.account_number,
    c.territory_id,

    c.person_id,
    c.store_id,

    -- Pessoa
    p.first_name,
    p.middle_name,
    p.last_name,

    -- Loja
    s.store_name,

    -- Endereço
    a.address_line_1,
    a.address_line_2,
    a.city,
    a.state_province_id,
    a.postal_code,

    -- Localização
    sp.state_province_name,
    sp.state_province_code,

    cr.country_region_name,
    cr.country_region_code

from customer c

left join person p
    on c.person_id = p.business_entity_id

left join store s
    on c.store_id = s.business_entity_id

left join person_address pa
    on c.person_id = pa.business_entity_id

left join store_address sa
    on c.store_id = sa.business_entity_id

left join address a
    on a.address_id = coalesce(pa.address_id, sa.address_id)

left join state_province sp
    on a.state_province_id = sp.state_province_id

left join country_region cr
    on sp.country_region_code = cr.country_region_code