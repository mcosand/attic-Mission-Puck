class RenameActionsToCommands < ActiveRecord::Migration
  def change
    rename_table :actions, :commands
  end
end
