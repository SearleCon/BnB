class AddMultipleIndexesAtOnce < ActiveRecord::Migration
  def up
    tables = ActiveRecord::Base.connection.tables - ["schema_migrations"]
    tables.each do |table|
      columns =  ActiveRecord::Base.connection.columns(table)
      foreign_keys = columns.find_all{|column| column.name.include? '_id'}
      foreign_keys.each do |foreign_key|
        add_index table, foreign_key.name unless ActiveRecord::Base.connection.index_exists?(table, foreign_key.name)
      end
    end

  end

  def down
  end
end
