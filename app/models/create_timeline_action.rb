class CreateTimelineAction < Action
  def created
    @created
  end

  def perform
    j = self.data
    responder = j[:responder] || Responder.find(j['responder_id'])
    unit = j[:unit] || Unit.find(j['unit_id'])

    @created = responder.timeline.build(j.slice("time", "miles"))
    @created.unit = unit
    @created.role = j['role']
    @created.status = j['status']

    v = @created.save!
# puts "@@@FINDME@@@ #{@created.inspect}"

    if (responder.current == nil || responder.current.time < @created.time) then
      responder.current = @created
      responder.save
# puts "@@@FINDME@@@ #{responder.errors.inspect}"
    end

    if (v) then
      self.reference = @created.id
      @created.responder = responder
    end
    v
  end
end
