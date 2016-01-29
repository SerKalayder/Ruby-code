require 'sequel'

Sequel.migration do
  change do
    alter_table(:reports) do
      set_column_allow_null(:title)
    end

    alter_table(:headers) do
      set_column_allow_null(:key)
      set_column_allow_null(:value)
    end

    alter_table(:links) do
      set_column_allow_null(:title)
      set_column_allow_null(:href)
      set_column_allow_null(:rel)
      set_column_allow_null(:target)
      set_column_allow_null(:download)
    end
  end

end
