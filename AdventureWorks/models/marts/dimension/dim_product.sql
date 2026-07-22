/*
------------------------------------------------------------------------------
Modelo.......: dim_product
Descrição....: Dimensão de produtos para a camada Gold. Limpa atributos, 
               trata valores nulos e consolida a hierarquia (Categoria > Subcategoria).
Granularidade: 1 registro por produto.
------------------------------------------------------------------------------
*/

{{ config(materialized='table') }}

with int_product as (

    select *
    from {{ ref('int_production__product') }}

)

select
    -- Identificação
    product_id,
    product_number,
    product_name,

    -- Hierarquia do Produto
    coalesce(product_category_name, 'Sem Categoria') as category_name,
    coalesce(product_subcategory_name, 'Sem Subcategoria') as subcategory_name,
    coalesce(product_model_name, 'Sem Modelo') as model_name,

    -- Características
    coalesce(color, 'Não Especificado') as color,
    size,
    product_line,
    product_class,
    style,
    
    -- Custos e Preços
    standard_cost,
    list_price,

    -- Flags de Negócio (Tratando para o BI)
    case when make_flag = true then 'Fabricação Própria' else 'Comprado' end as make_type,
    case when finished_goods_flag = true then 'Produto Acabado' else 'Componente' end as product_status,

    -- Descrição
    product_description

from int_product