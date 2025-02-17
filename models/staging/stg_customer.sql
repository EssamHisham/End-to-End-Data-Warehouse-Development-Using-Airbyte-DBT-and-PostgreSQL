{{
  config(
    materialized='table'
  )
}}

-- stg_customer model
with source as (
    select * from {{ source('src_postgres', 'DB_Customer') }}
),

renamed as (
    select
        "StoreID" as storeid,
        "PersonID" as personid,
        "CustomerID" as customerid,
        "TerritoryID" as territoryid,
        "ModifiedDate" as modifieddate,
        "AccountNumber" as accountnumber
    from source
)

select * from renamed