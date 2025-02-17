{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_productcategory') }}
),

renamed as (
    select
        "ModifiedDate" as "modifieddate",
        "ProductCategory" as "productcategory",
        "ProductCategoryID" as "productcategoryid"
    from source
)

select * from renamed
