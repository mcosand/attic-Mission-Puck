class MissionsController < ApplicationController
  def show
    @mission = Mission.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @mission }
    end
  end
end
