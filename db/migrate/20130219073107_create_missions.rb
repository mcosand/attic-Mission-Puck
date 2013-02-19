class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :title
      t.datetime :started
      t.string :number
      t.string :county

      t.timestamps
    end
  end
end
