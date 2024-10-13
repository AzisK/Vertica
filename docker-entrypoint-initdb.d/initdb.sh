#!/bin/bash

# Full path to the vsql binary
VSQL="/opt/vertica/bin/vsql -U dbadmin -d VMart"

# Function to check if the InitiateDatabase table exists
init_table_exists() {
    local query="SELECT EXISTS (SELECT 1 FROM v_catalog.tables WHERE table_name = 'InitiateDatabase');"
    local result=$($VSQL -c "$query" | grep -w "t")
    if [ -n "$result" ]; then
        return 0
    else
        return 1
    fi
}

# Check if the InitiateDatabase table exists
if ! init_table_exists; then
    echo "InitiateDatabase table does not exist. Initializing database..."

    # Run all .vsql scripts in the current directory
    for sql_file in $(ls /docker-entrypoint-initdb.d/*.vsql | sort); do
        echo "Running $sql_file..."
        $VSQL -f "$sql_file" > /tmp/vsql_output.log 2>&1
        if [ $? -ne 0 ]; then
            echo "Error running $sql_file. Check /tmp/vsql_output.log for details."
        else
            echo "Successfully ran $sql_file"
        fi
    done
else
    echo "Database has already been initialized."
fi
