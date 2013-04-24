class RosterTimelinesController < ApplicationController
  before_filter :find_mission

  before_filter :check_for_mobile

  def create

    cmd = Commands::UpdateResponderStatusCommand.make(@mission.id, params[:timeline])

    respond_to do |format|
      if cmd.execute
        broadcast "/responders/update", cmd.model.to_json

        format.html
        format.json { render :json => cmd.model }
      else
        format.html { render :action => "new" }
        format.json { render :json => cmd.model.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
    def find_mission
      @mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
    end
end
