class Commands::AssignTeamMemberCommand < Commands::Command
  def team
    @team
  end

  def model
    @responder
  end

  class << self
    alias make_base make
    def make(responder_id, team_id, is_leader, team_data, keep_team)
      raise "responder_id not set" unless responder_id
      make_base(responder_id, {
        'team_id' => team_id,
        'leader' => is_leader,
        'team_data' => team_data,
        'keep_team' => keep_team
      })
    end
  end

  def internal_execute
    val = true

     @responder = Responder.find(self.reference)

    puts self.data.inspect 
     if (self.data['team_id'] and self.data['team_id'] != "") then
       @team = Team.find(self.data['team_id'])
     else
       data = self.data['team_data'].merge({'mission_id' => @responder.mission_id, 'kind' => :field})
       cmd = Commands::UpdateCommand.make(nil, 'Team', data)
       val |= cmd.execute
       @team = cmd.model
     end       


     new_status = nil
     if (@responder.current.status != :assigned && @team.kind != :staging) then
       new_status = :assigned
     elsif (@responder.current.status != :status && @team.kind == :staging) then
       new_status = :signedin
     end

     old_team = @responder.team
     old_team_count = @responder.team.members.count

     if new_status then
       self.when ||= Time.now


       cmd = Commands::UpdateResponderStatusCommand.make(@team.mission_id, {
         'responder_id' => @responder.id,
         'unit_id' => @responder.current.unit_id,
         'time' => self.when,
         'status' => new_status,
         'role' => @responder.current.role
       })
       val |= cmd.execute
     end

     if (old_team and 
         old_team.kind == :field and
         old_team_count == 1 and
         self.data['keep_team'] == nil) then
       cmd = Commands::DestroyCommand.make(old_team.id, 'Team')
       val |= cmd.execute
     end


     if (self.data['leader']) then
       @team.leader = @responder
       val &= @team.save
     end

     @responder.team = @team
     val &= @responder.save

     val 
  end
end
