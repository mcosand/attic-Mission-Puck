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
		@log = @mission.logs.build(params[:log])

		respond_to do |format|
			if @log.save
		    broadcast "/logs/new", @log.to_json

				format.html # new.html.erb
				format.json { render :json => @log }
			else
				format.html { render :action => "new" }
				format.json { render :json => @log.errors, :status => :unprocessable_entity }
			end
		end
	end

  def destroy
    @log = @mission.logs.find(params[:id])
    @log.destroy
    broadcast "/logs/delete", params[:id]
    render :json => params[:id]
  end

	private
		def find_mission
			@mission = Mission.find(params[:mission_id])
		end
end
