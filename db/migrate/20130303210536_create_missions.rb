class CreateMissions < ActiveRecord::Migration
  def self.up
    create_table :missions, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.string :title
      t.datetime :started
      t.string :number
      t.string :county
    end
#    add_index :missions, :id
  end

  def self.down
    drop_table :missions
  end
end
