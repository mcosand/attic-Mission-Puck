class LogsController < ApplicationController
  before_filter :find_mission

  before_filter :check_for_mobile

  def index
    @logs = @mission.logs.all( :order => '"when" DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @logs }
    end
  end

  def create
    cmd = Commands::UpdateCommand.make(nil, 'Log', params[:log])
    cmd.data['keys'] = {:mission_id => @mission.id.as_json}
    respond_to do |format|
      if cmd.execute
        broadcast "/logs/new", cmd.model.to_json

        format.html
        format.json { render :json => cmd.model }
      else
        format.html { render :action => "new" }
        format.json { render :json => cmd.model.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    cmd = Commands::DestroyCommand.make(params[:id],'Log') 
    if (cmd.execute) then
      broadcast "/logs/delete", params[:id]
      render :json => params[:id]
    end
  end

  private
    def find_mission
      @mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
    end
end
