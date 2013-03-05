class DestroyLogAction < Action
  def perform
    j = JSON.parse(self.data)
    mission = Mission.find(UUIDTools::UUID.parse(j['mission_id']))
    log = mission.logs.find(UUIDTools::UUID.parse(j['id']))
    log.destroy
  end
end
