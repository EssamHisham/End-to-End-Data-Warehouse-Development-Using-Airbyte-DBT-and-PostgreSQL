{{ config(
    materialized='table'
) }}
select 
     {{ dbt_utils.generate_surrogate_key(['stg_salesterritory.territoryid']) }} as territory_key,
    territoryid, 
    salesterritoryname, 
    "group" as territory_group, 
    countryregioncode, 
    costytd,  
    salesytd, 
    costlastyear,
    saleslastyear,
    modifieddate
from {{ ref('stg_salesterritory') }}