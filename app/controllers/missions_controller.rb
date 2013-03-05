class MissionsController < ApplicationController
  before_filter :check_for_mobile

  def show
    @mission = Mission.find(UUIDTools::UUID.parse(params[:id]))
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mission }
    end
  end

  # Get the N (default 1) most recent missions
  # GET /missions/mostrecent
  # GET /missions/mostrecent/5
  def mostrecent
    count = params[:id] || 1
    render :json => Mission.find(:all, :limit => count, :order => 'started DESC')
  end
end
