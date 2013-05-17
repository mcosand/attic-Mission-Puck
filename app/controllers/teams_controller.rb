class TeamsController < ApplicationController
  before_filter :find_mission

  before_filter :check_for_mobile

  def index
    teams = @mission.teams.includes(:members => :current).all
    answer = {:field => []}
    teams.each do |t|
      answer[t.kind.to_s] ||= []
      answer[t.kind.to_s] << t.as_json(:include => {:members => {:include => :current}}, :except => :mission_id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => answer.to_json(:include => :members) }
    end
  end

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
