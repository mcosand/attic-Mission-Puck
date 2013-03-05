class CreateAction < ActiveRecord::Migration
  def self.up
    create_table :actions, :id => false do |t|
      t.uuid :id, :primary_key => true

      t.string :type
      t.uuid :reference
  
      t.datetime :when
      t.string :source

      t.text :data
    end
  end

  def self.down
    drop_table :actions
  end
end
