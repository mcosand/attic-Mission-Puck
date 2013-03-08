class CreateMissionAction < Action
  def created
		@created
  end

  def perform
    j = self.data #JSON.parse(self.data)
    @created = Mission.create(j.reject{|k,v| k.end_with? "id"})
    
    v = @created.save
    if (v) then self.reference = @created.id end
    v
  end
end
