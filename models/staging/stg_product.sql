{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_product') }}
),

renamed as (
    select
        "Size" as "size",
        "Class" as "class",
        "Color" as "color",
        "Style" as "style",
        "Weight" as "weight",
        "MakeFlag" as "makeflag",
        "ListPrice" as "listprice",
        "ProductID" as "productid",
        "ProductLine" as "productline",
        "ProductName" as "productname",
        "SellEndDate" as "sellenddate",
        "ModifiedDate" as "modifieddate",
        "ReorderPoint" as "reorderpoint",
        "StandardCost" as "standardcost",
        "ProductNumber" as "productnumber",
        "SellStartDate" as "sellstartdate",
        "ProductModelID" as "productmodelid",
        "DiscontinuedDate" as "discontinueddate",
        "SafetyStockLevel" as "safetystocklevel",
        "DaysToManufacture" as "daystomanufacture",
        "FinishedGoodsFlag" as "finishedgoodsflag",
        "SizeUnitMeasureCode" as "sizeunitmeasurecode",
        "ProductSubcategoryID" as "productsubcategoryid",
        "WeightUnitMeasureCode" as "weightunitmeasurecode"
    from source
)

select * from renamed
