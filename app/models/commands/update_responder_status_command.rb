class Commands::UpdateResponderStatusCommand < Commands::UpdateCommand
  def responder
    @responder
  end

  def unit
    @unit
  end

  class << self
    def make(mission_id, data)
      raise "mission_id not set" unless mission_id
      make_base(nil, {
        'type' => 'RosterTimeline',
        'data' => data,
        'keys' => { 'mission_id' => mission_id }
      })
    end
  end

  def internal_execute
     $result = true

     data = self.data['data']
     if (data['responder_id']) then
       @responder = Responder.find(data['responder_id'])
     else 
       cmd = Commands::UpdateCommand.make(nil, 'Responder', data['responder'])
       cmd.data['keys'] = {'mission_id' => self.data['keys']['mission_id'] }
       cmd.topmost = false
       $result = $result & cmd.execute
       @responder = cmd.model
     end

     if (data['unit_id']) then
       @unit = Unit.find(data['unit_id'])
     else
       cmd = Commands::UpdateCommand.make(nil, 'Unit', data['unit'])
       cmd.data['keys'] = {:mission_id => self.data['keys']['mission_id'] }
       cmd.topmost = false
       $result = $result & cmd.execute
       @unit = cmd.model
     end

     raise ActiveRecord::Rollback unless $result
       
     self.data['keys'] = {:responder_id => @responder.id, :unit_id => @unit.id }
     $result = $result & super

     if (@responder.current == nil || @responder.current.time < @model.time) then
       @responder.current = @model
       $result = $result & @responder.save
     end

     raise ActiveRecord::Rollback unless $result

     $result
  end
end
