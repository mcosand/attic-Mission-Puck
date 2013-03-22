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

#  def create
#    args = params[:log]
#    args['mission_id'] = @mission.id.to_s
#    act = CreateLogAction.new(:data => args, :when => Time.now, :source => "@#{`hostname`.strip}")

#    val = false
#    act.transaction do
#      val = act.perform
#      act.save
#    end

#    respond_to do |format|
#      if val
#        broadcast "/logs/new", act.created.to_json

#        format.html # new.html.erb
#        format.json { render :json => act.created }
#      else
#        format.html { render :action => "new" }
#        format.json { render :json => act.created.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

#  def destroy
#    log = @mission.logs.find(params[:id])
#    act = DestroyLogAction.new(:data => {:id => log.id, :mission_id => log.mission_id}.to_json, :when => Time.now, :source => "@{`hostname`.strip}")

#    act.transaction do
#      act.perform
#      act.save
#    end

#    broadcast "/logs/delete", params[:id]
#    render :json => params[:id]
#  end

  def post_update
     puts params.inspect
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
