class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.uuid :mission_id, :null => false
      t.uuid :leader_id

      t.string :name
      t.string :kind
    end

    add_column :responders, :team_id, :uuid
  end
end
