class DestroyMissionAction < Action
  def perform
    j = JSON.parse(self.data)
    mission = Mission.find(UUIDTools::UUID.parse(j))
    mission.destroy
  end
end
