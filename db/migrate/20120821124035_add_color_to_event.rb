class AddColorToEvent < ActiveRecord::Migration
  def change
    add_column :events, :color, :string, :default => 'blue'
    Event.find_each do |event|
      event.color =  'blue'
      event.save
    end
  end
end
