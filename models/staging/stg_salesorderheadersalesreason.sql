{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('src_postgres', 'DB_SalesOrderHeaderSalesReason') }}

),

renamed as (

    select
        "ModifiedDate" as "modifieddate",
        "SalesOrderID" as "salesorderid",
        "SalesReasonID" as "salesreasonid"
    from source

)

select * from renamed
