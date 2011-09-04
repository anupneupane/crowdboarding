class CreateCity < ActiveRecord::Migration
  def self.up
    create_table :cities, :force => true do |t|
      t.string :name, :limit => 100, :null => false
      t.integer :country_id, :null => false
    end

    City.create!(:name => "Madrid", :country_id => Country.find_by_name('Spain').id)
    City.create!(:name => "Barcelona", :country_id => Country.find_by_name('Spain').id)
    City.create!(:name => "Valencia", :country_id => Country.find_by_name('Spain').id)
    City.create!(:name => "Sevilla", :country_id => Country.find_by_name('Spain').id)
  end

  def self.down
    drop_table :cities
  end
end