class CreateLogAction < Action
  def perform
    j = JSON.parse(self.data)
    mission = Mission.find(UUIDTools::UUID.parse(j['mission_id']))
    log = mission.logs.create(j.reject{|k,v| k.end_with? "id"})
    v = log.save
    self.reference = log.id
    v
  end
end
