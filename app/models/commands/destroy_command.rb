class Commands::DestroyCommand < Commands::Command
  def internal_execute
    objType = eval self.data

    obj = objType.find(self.reference)
    obj.destroy

    true
  end
end
