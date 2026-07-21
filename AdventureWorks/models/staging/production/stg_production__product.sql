/*
------------------------------------------------------------------------------
Modelo.......: stg_production__product
Camada.......: Staging
Origem.......: adventureworks.bronze.product

Descrição....:
Padroniza os dados da tabela Product da camada Bronze.

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

    -- Identificação do produto
    ProductID                  as product_id,

    -- Informações básicas
    Name                       as product_name,
    ProductNumber              as product_number,

    -- Indicadores
    MakeFlag                   as make_flag,
    FinishedGoodsFlag          as finished_goods_flag,

    -- Características
    Color                      as color,
    Size                       as size,
    SizeUnitMeasureCode        as size_unit_measure_code,
    WeightUnitMeasureCode      as weight_unit_measure_code,
    Weight                     as weight,

    -- Estoque
    SafetyStockLevel           as safety_stock_level,
    ReorderPoint               as reorder_point,

    -- Valores
    StandardCost               as standard_cost,
    ListPrice                  as list_price,

    -- Produção
    DaysToManufacture          as days_to_manufacture,
    ProductLine                as product_line,
    Class                      as product_class,
    Style                      as style,

    -- Relacionamentos
    ProductSubcategoryID       as product_subcategory_id,
    ProductModelID             as product_model_id,

    -- Vigência
    SellStartDate              as sell_start_date,
    SellEndDate                as sell_end_date,
    DiscontinuedDate           as discontinued_date,

    -- Auditoria
    rowguid                    as row_guid,
    ModifiedDate               as modified_date

from {{ source('bronze', 'product') }}