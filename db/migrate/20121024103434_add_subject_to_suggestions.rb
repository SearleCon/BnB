class AddSubjectToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :subject, :string

  end
end
