{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'DB_vw_productsubcategory') }}
),

renamed as (
    select
        "ModifiedDate" as "modifieddate",
        "ProductCategoryID" as "productcategoryid",
        "ProductSubCategory" as "productsubcategory",  -- Changed to match the correct column name
        "ProductSubcategoryID" as "productsubcategoryid"
    from source
)

select * from renamed
