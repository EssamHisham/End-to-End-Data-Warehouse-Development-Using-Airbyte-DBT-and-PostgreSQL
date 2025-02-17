{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('src_postgres', 'DB_vw_person') }}

),

renamed as (

    select
        "Title" as "title",
        "Gender" as "gender",
        "Suffix" as "suffix",
        "LastName" as "lastname",
        "BirthDate" as "birthdate",
        "Education" as "education",
        "FirstName" as "firstname",
        "NameStyle" as "namestyle",
        "MiddleName" as "middlename",
        "Occupation" as "occupation",
        "PersonType" as "persontype",
        "ModifiedDate" as "modifieddate",
        "MaritalStatus" as "maritalstatus",
        "TotalChildren" as "totalchildren",
        "EmailPromotion" as "emailpromotion",
        "HouseOwnerFlag" as "houseownerflag",
        "CommuteDistance" as "commutedistance",
        "NumberCarsOwned" as "numbercarsowned",
        "BusinessEntityID" as "businessentityid",
        "DateFirstPurchase" as "datefirstpurchase",
        "NumberChildrenAtHome" as "numberchildrenathome"
    from source

)

select * from renamed
