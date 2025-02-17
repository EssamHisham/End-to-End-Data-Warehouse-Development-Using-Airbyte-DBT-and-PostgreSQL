{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_store') }}
),

renamed as (
    select
        "StoreName" as "storename",
        "Demographics" as "demographics",
        "ModifiedDate" as "modifieddate",
        "SalesPersonID" as "salespersonid",
        "BusinessEntityID" as "businessentityid"
    from source
)

select * from renamed
