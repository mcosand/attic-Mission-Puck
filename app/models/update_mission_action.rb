class UpdateMissionAction < Action
  def model
		@mission
  end

  def perform
    j = self.data
   
    @mission = Mission.find(self.reference)
    @mission.update_attributes(j)
  end
end
