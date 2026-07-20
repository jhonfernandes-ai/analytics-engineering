/*
------------------------------------------------------------------------------
Modelo.......: stg_sales__order_header
Camada.......: Staging
Origem.......: adventureworks.bronze.salesorderheader

Descrição....:
Padroniza os dados da tabela SalesOrderHeader da camada Bronze.
Nesta etapa são realizadas apenas padronizações de nomenclatura e organização
das colunas. Nenhuma regra de negócio é aplicada.

Autor........: Jonathas Fernandes
Projeto......: AdventureWorks Analytics Engineering Challenge
------------------------------------------------------------------------------
*/

{{ config(materialized='view') }}

select

    -- Identificação do pedido
    SalesOrderID         as sales_order_id,
    RevisionNumber       as revision_number,
    SalesOrderNumber     as sales_order_number,
    PurchaseOrderNumber  as purchase_order_number,
    AccountNumber        as account_number,

    -- Datas
    OrderDate            as order_date,
    DueDate              as due_date,
    ShipDate             as ship_date,

    -- Status do pedido
    Status               as status,
    OnlineOrderFlag      as online_order_flag,

    -- Cliente e vendedor
    CustomerID           as customer_id,
    SalesPersonID        as sales_person_id,
    TerritoryID          as territory_id,

    -- Endereços
    BillToAddressID      as bill_to_address_id,
    ShipToAddressID      as ship_to_address_id,

    -- Transporte
    ShipMethodID         as ship_method_id,

    -- Pagamento
    CreditCardID         as credit_card_id,

    -- Valores financeiros
    SubTotal             as subtotal_amount,
    TaxAmt               as tax_amount,
    Freight              as freight_amount,
    TotalDue             as total_due_amount,

    -- Auditoria
    rowguid              as row_guid,
    ModifiedDate         as modified_date

from {{ source('bronze', 'salesorderheader') }}