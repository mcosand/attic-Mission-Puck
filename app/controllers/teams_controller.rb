class TeamsController < ApplicationController
  before_filter :find_mission

  before_filter :check_for_mobile

  def builder 
    respond_to do |format|
      format.html # builder.html.erb
    end
  end

  private
    def find_mission
      @mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
    end
end
