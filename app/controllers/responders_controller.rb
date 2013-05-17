class RespondersController < ApplicationController
  before_filter :find_mission
  before_filter :check_for_mobile

  def index
    responders = @mission.responders.all( :order => '"lastname" DESC, "firstname" DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => responders.as_json(:include => { :current => {:include => { :unit => { :only => ["name"] } }, :except => ["id"] } }) }
    end
  end

  def team
    cmd = Commands::AssignTeamMemberCommand.make(
            params[:id],
            params[:team_id],
            params[:is_leader],
            params[:team],
            params[:keep_team])

    val = cmd.execute

    respond_to do |format|
      if val then
        format.json { render :json => cmd.model }
      else
#        format.json { render :json => cmd.model.errors, :status => :unprocessable_entity }
        format.json { render :json => 'error', :status => :unprocessable_entity }
      end
    end
  end

  def search
    key = params[:q]
    (lastname,firstname) = key.split(',', 2).collect{|x| x.strip}

    if (firstname == nil) then
      (firstname, lastname) = key.split(' ', 2).collect{|x| x.strip}
    end

    if (lastname == nil) then
      (firstname, lastname) = ["", firstname]
    end

    # Find every member in the database that matches
    # Add anyone on the mission that isn't from the database
    # Add new temp responder

    query = "lastname like ?" + (firstname ? " AND firstname like ?" : "")
    
    on_mission = @mission.responders.where(query, "#{lastname}%", "#{firstname}%")
                 .concat(@mission.responders.where(query, "#{firstname}%", "#{lastname}%"))
   
    render :json => on_mission.map{|item| {:id => item.id, :firstname => item.firstname, :lastname => item.lastname, :isTemp => true, :status => item.current.status}}.concat([{:firstname => firstname, :lastname => lastname, :isTemp => true, :status => 'unknown'}])
  end

  private
    def find_mission
      @mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
    end
end
