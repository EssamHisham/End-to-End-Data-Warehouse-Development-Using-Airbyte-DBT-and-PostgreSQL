{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_salesterritory') }}
),

renamed as (
    select
        "Group" as "group",
        "CostYTD" as "costytd",
        "SalesYTD" as "salesytd",
        "TerritoryID" as "territoryid",
        "CostLastYear" as "costlastyear",
        "ModifiedDate" as "modifieddate",
        "SalesLastYear" as "saleslastyear",
        "CountryRegionCode" as "countryregioncode",
        "SalesTerritoryName" as "salesterritoryname"
    from source
)

select * from renamed