{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_salesorderheader') }}
),

renamed as (
    select
        "CustomerID" as "customerid",
        "Status" as "status",
        "TaxAmt" as "taxamt",
        "Comment" as "comment",
        "DueDate" as "duedate",
        "Freight" as "freight",
        "ShipDate" as "shipdate",
        "SubTotal" as "subtotal",
        "TotalDue" as "totaldue",
        "OrderDate" as "orderdate",
        "TerritoryID" as "territoryid",
        "CreditCardID" as "creditcardid",
        "ModifiedDate" as "modifieddate",
        "SalesOrderID" as "salesorderid",
        "ShipMethodID" as "shipmethodid",
        "AccountNumber" as "accountnumber",
        "SalesPersonID" as "salespersonid",
        "CurrencyRateID" as "currencyrateid",
        "RevisionNumber" as "revisionnumber",
        "BillToAddressID" as "billtoaddressid",
        "OnlineOrderFlag" as "onlineorderflag",
        "ShipToAddressID" as "shiptoaddressid",
        "SalesOrderNumber" as "salesordernumber",
        "PurchaseOrderNumber" as "purchaseordernumber",
        "CreditCardApprovalCode" as "creditcardapprovalcode"
    from source
)

select * from renamed