require 'sequel'

Sequel.migration do
  up do
    create_table(:reports) do
      primary_key :id
      String :url, :null=>false
      String :title, :null=>false
      String :ip, :null=>false
      DateTime :created_at, :null=>false
    end

    create_table(:headers) do
      String :url, :null => false
      String :key, :null => false
      String :value, :null => false
    end

    create_table(:links) do
      String :url, :null=>false
      String :title, :null=>false
      String :href, :null=>false
      String :rel, :null=>false
      String :target, :null=>false
      String :download, :null=>false
      String :number, :null=>false
    end
  end

  down do
    drop_table(:reports)
    drop_table(:headers)
    drop_table(:links)
  end
end
