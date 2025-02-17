{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_countryregion') }}
),

renamed as (
    select
        "ModifiedDate" as "modifieddate",
        "CountryRegionCode" as "countryregioncode",
        "CountryRegionName" as "countryregionname"
    from source
)

select * from renamed
