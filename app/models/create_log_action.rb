class CreateLogAction < Action
  def created
    @created
  end

  def perform
    j = self.data
    mission = Mission.find(UUIDTools::UUID.parse(j['mission_id']))
    @created = mission.logs.create(j.reject{|k,v| k.end_with? "id"})
    v = @created.save
    if (v) then self.reference = @created.id end
    v
  end
end
