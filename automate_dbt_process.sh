#!/bin/bash

# Define the list of relevant tables
tables=(
    "DB_vw_CountryRegion" "DB_vw_Person" "DB_vw_Product" "DB_vw_ProductSubcategory" "DB_vw_SalesOrderHeader"
    "DB_vw_SalesReason" "DB_vw_SalesTerritory" "DB_vw_StateProvince" "DB_vw_Store"
    "DB_SalesOrderHeader" "DB_SalesOrderHeaderSalesReason" "DB_SalesOrderDetail" "DB_BusinessEntityAddress"
)

# Path to your dbt project directory
dbt_project_dir="/Users/poco/warehouse"

# schema.yaml file path (in the staging directory)
schema_file="$dbt_project_dir/models/staging/schema.yml"

# Create staging directory if it doesn't exist
mkdir -p "$dbt_project_dir/models/staging"

# Create schema.yaml file with version and models section if it doesn't exist
if [ ! -f "$schema_file" ]; then
    echo "Creating $schema_file..."
    echo "version: 2" > "$schema_file"
    echo "models:" >> "$schema_file"
fi

echo "Starting dbt model generation and schema.yaml update..."

for table in "${tables[@]}"; do
    echo "Processing ${table}..."

    # 1. Generate SQL file using dbt run-operation (if it doesn't exist)
    stg_table_name=$(echo "$table" | sed 's/^DB_//;s/^DB_vw_//')
    output_file="$dbt_project_dir/models/staging/stg_${stg_table_name}.sql"

    if [ ! -f "$output_file" ]; then
        echo "Generating SQL file: $output_file"
        dbt run-operation generate_base_model --args "{'source_name': 'src_postgres', 'table_name': '${table}'}" > "$output_file"
        echo "Generated $output_file"
    else
        echo "SQL file $output_file already exists. Skipping generation."
    fi


    # 2. Run dbt
    dbt run --select "stg_${stg_table_name}"

    # 3. Generate model YAML (and sanitize output)
    model_yaml=$(dbt run-operation generate_model_yaml --args "{model_names: ['stg_${stg_table_name}']}" | sed '/^models:/d' | tr -d '\001\033')

    # 4. Update schema.yaml (only if the model doesn't exist)
    if [[ ! -z "$model_yaml" ]]; then  # Check if model_yaml is not empty
        if ! grep -q "name: stg_${stg_table_name}" "$schema_file"; then # Check if model exists
            # Use sed to insert the YAML (handles both insert and append)
            sed -i "/^ *- name:/i${model_yaml}" "$schema_file" || echo "$model_yaml" >> "$schema_file"
            echo "Schema.yaml updated for ${stg_table_name}."
        else
            echo "Model stg_${stg_table_name} already exists in $schema_file. Skipping."
        fi
    else
        echo "Warning: No model YAML generated for ${stg_table_name}. dbt run-operation may have failed."
    fi

done

echo "dbt model generation and schema.yaml update complete."