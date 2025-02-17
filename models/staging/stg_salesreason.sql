{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_salesreason') }}
),

renamed as (
    select
        "ReasonType" as "reasontype",
        "SalesReason" as "salesreason",
        "ModifiedDate" as "modifieddate",
        "SalesReasonID" as "salesreasonid"
    from source
)

select * from renamed
