class DestroyMissionAction < Action
  def perform
    mission = Mission.find(UUIDTools::UUID.parse(self.data))
    mission.destroy
  end
end
