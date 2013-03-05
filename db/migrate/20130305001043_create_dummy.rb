## This class exists simply so that a sqlite_sequence table is created
## in sqlite databases. cucumber tasks want to delete rows from the sequence table
class CreateDummy < ActiveRecord::Migration
  def self.up
    create_table :dummy do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :dummy
  end
end
