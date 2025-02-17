{{
  config(
    materialized='table'
  )
}}
with source as (
    select * 
    from {{ source('src_postgres', 'DB_BusinessEntityAddress') }}
),

renamed as (
    select
        "AddressID" as "addressid",
        "ModifiedDate" as "modifieddate",
        "AddressTypeID" as "addresstypeid",
        "BusinessEntityID" as "businessentityid"

    from source
)

select * from renamed
