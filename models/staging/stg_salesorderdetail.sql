{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('src_postgres', 'DB_SalesOrderDetail') }}

),

renamed as (

    select
        "OrderQty" as "orderqty",
        "LineTotal" as "linetotal",
        "ProductID" as "productid",
        "UnitPrice" as "unitprice",
        "ModifiedDate" as "modifieddate",
        "SalesOrderID" as "salesorderid",
        "SpecialOfferID" as "specialofferid",
        "UnitPriceDiscount" as "unitpricediscount",
        "SalesOrderDetailID" as "salesorderdetailid",
        "CarrierTrackingNumber" as "carriertrackingnumber"
    from source

)

select * from renamed
