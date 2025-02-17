{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_stateprovince') }}
),

renamed as (
    select
        "TerritoryID" as "territoryid",
        "ModifiedDate" as "modifieddate",
        "StateProvinceID" as "stateprovinceid",
        "StatProvinceName" as "statprovincename",
        "CountryRegionCode" as "countryregioncode",
        "StateProvinceCode" as "stateprovincecode",
        "IsOnlyStateProvinceFlag" as "isonlystateprovinceflag"
    from source
)

select * from renamed