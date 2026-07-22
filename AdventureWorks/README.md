# 🚴 Adventure Works - Data Warehouse & Analytics Engineering

Este repositório contém a solução fim a fim de Engenharia e Análise de Dados para a **Adventure Works**, utilizando **Databricks**, **dbt Cloud** e **Power BI**.

---

## 🎯 Objetivos do Projeto
* Consolidação dos dados operacionais (ERP/CRM) do Adventure Works em um Data Lakehouse/DW moderno.
* Modelagem em **Star Schema** (Dimensional) para facilitar análises de vendas, clientes, produtos e motivos de compra.
* Implementação de testes automatizados de qualidade e integridade referencial de dados.
* Criação de painel interativo no Power BI para suporte a tomada de decisão executiva.

---

## 🏗️ Arquitetura da Solução
    [ ERP / Dados Brutos (OLTP) ]
                  │
                  ▼
    [ Databricks (Delta Lake) ]
                  │
                  ▼
    [ dbt Cloud ] ──► (Staging ➔ Marts / Gold)
                  │
                  ▼
    [ Power BI Dashboard ]

* **Data Lakehouse / DW:** Databricks (Delta Lake)
* **Transformação & Modelagem:** dbt Cloud (Arquitetura Medallion / Staging -> Marts)
* **Qualidade & Testes:** dbt test (`unique`, `not_null`, `relationships`)
* **Visualização:** Power BI

---

## 📊 Matriz de KPIs e Métricas de Negócio

| Métrica / KPI | Definição / Regra de Negócio | Localização no dbt |
| :--- | :--- | :--- |
| **Receita Bruta** | `unit_price * order_qty` | `fact_sales` |
| **Desconto Aplicado** | `unit_price * order_qty * unit_price_discount` | `fact_sales` |
| **Receita Líquida** | `subtotal - desconto_aplicado` | `fact_sales` |
| **Imposto Rateado** | Rateio proporcional do `tax_amt` do cabeçalho pelo subtotal do item | `fact_sales` |
| **Frete Rateado** | Rateio proporcional do `freight` do cabeçalho pelo subtotal do item | `fact_sales` |
| **Custo Total** | `standard_cost * order_qty` (buscado da dimensão de produtos) | `fact_sales` |
| **Margem de Lucro** | `receita_liquida - (custo_total + imposto_rateado + frete_rateado)` | `fact_sales` |

---

## 📐 Modelagem Dimensional (Star Schema)

A camada **Marts (Gold)** foi modelada no padrão dimensional de Kimball:

* **`fact_sales`**: Tabela fato granular por item de pedido (`sales_order_detail_id`), contendo valores financeiros rateados e chaves estrangeiras.
* **`dim_customer`**: Consolida clientes B2B (Store) e B2C (Individual), padronizando nomes, tipos e endereços de entrega.
* **`dim_product`**: Hierarquia completa de produtos, subcategorias e categorias.
* **`dim_date`**: Dimensão calendário para análise temporal detalhada.
* **`dim_sales_reason` & `bridge_sales_reason`**: Tabela ponte para resolver o relacionamento $N:M$ de motivos de venda sem duplicar métricas financeiras.

> 📄 *O diagrama conceitual do modelo ER/Dimensional está disponível na pasta `docs/diagrama_conceitual_dw.pdf`.*

---

## 🛡️ Testes de Qualidade de Dados & Governança

Para garantir integridade de dados e taxa zero de registros órfãos, foram aplicados os seguintes testes via dbt:

1. **Fontes (`staging`):** Testes `not_null` e `unique` nas chaves primárias do ERP.
2. **Dimensões, Ponte e Fato (`marts`):** 
   * Testes de unicidade e não-nulidade em chaves primárias e substitutas (`date_sk`).
   * Testes de **Integridade Referencial (`relationships`)** entre `fact_sales` / `bridge_sales_reason` e as dimensões `dim_customer`, `dim_product` e `dim_sales_reason`.