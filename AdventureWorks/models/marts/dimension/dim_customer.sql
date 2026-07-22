/*
------------------------------------------------------------------------------
Modelo.......: dim_customer
Descrição....: Dimensão de clientes para a camada Gold. Unifica os clientes
               pessoa física (B2C) e jurídica/lojas (B2B), enriquecendo com 
               informações geográficas de endereço.
Granularidade: 1 registro por cliente (customer_id).
------------------------------------------------------------------------------
*/

/*
------------------------------------------------------------------------------
Modelo.......: dim_customer
Descrição....: Dimensão de clientes para a camada Gold. Unifica os clientes
               pessoa física (B2C) e jurídica/lojas (B2B), enriquecendo com 
               informações geográficas de endereço.
Granularidade: 1 registro por cliente (customer_id).
------------------------------------------------------------------------------
*/

{{ config(materialized='table') }}

with int_customer as (

    select *
    from {{ ref('int_person__customer') }}

),

customer_prep as (

    select
        *,
        -- Concatena o nome completo tratando espaços em branco e nulos
        nullif(
            trim(
                concat_ws(' ', 
                    nullif(trim(first_name), ''), 
                    nullif(trim(middle_name), ''), 
                    nullif(trim(last_name), '')
                )
            ), 
            ''
        ) as full_name
    from int_customer

)

select
    -- Identificação Principal
    customer_id,
    account_number,
    territory_id,

    -- Regra de Negócio: Classificação B2B vs B2C
    case
        when store_id is not null then 'B2B - Store'
        else 'B2C - Person'
    end as customer_type,

    -- Coluna Consolidada para Visualização no BI
    coalesce(store_name, full_name, 'Cliente Sem Nome') as customer_display_name,

    -- Detalhes B2C (Pessoa Física)
    person_id,
    first_name,
    middle_name,
    last_name,
    full_name,

    -- Detalhes B2B (Loja)
    store_id,
    store_name,

    -- Localização Geográfica e Endereço
    coalesce(address_line_1, 'Não Informado') as address_line_1,
    coalesce(address_line_2, '') as address_line_2,
    coalesce(city, 'Não Informado') as city,
    coalesce(postal_code, 'Não Informado') as postal_code,
    coalesce(state_province_name, 'Não Informado') as state_name,
    coalesce(state_province_code, 'N/A') as state_code,
    coalesce(country_region_name, 'Não Informado') as country_name,
    coalesce(country_region_code, 'N/A') as country_code

from customer_prep

