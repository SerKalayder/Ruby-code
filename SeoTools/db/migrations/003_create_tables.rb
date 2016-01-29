require 'sequel'

Sequel.migration do
  change do
    alter_table(:headers) do
      add_primary_key(:id)
    end

    alter_table(:links) do
      add_primary_key(:id)
    end
  end

end
