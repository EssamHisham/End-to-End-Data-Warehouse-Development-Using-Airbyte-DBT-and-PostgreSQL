{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_Address') }}
),

renamed as (
    select
        "City" as city,
        "AddressID" as addressid,
        "PostalCode" as postalcode,
        "AddressLine1" as addressline1,
        "AddressLine2" as addressline2,
        "ModifiedDate" as modifieddate,
        "SpatialLocation" as spatiallocation,
        "StateProvinceID" as stateprovinceid
    from source
)

select * from renamed