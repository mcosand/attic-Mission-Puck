class LogsController < ApplicationController
	before_filter :find_mission

	def index
		@logs = @mission.logs.all
	end

	def create
		@log = @mission.logs.build(params[:log])

		respond_to do |format|
			if @log.save
		    logger.info 'In observer handler'
		    puts 'In observer handler'
		    broadcast "/logs/new", @log.to_json

				format.html # new.html.erb
				format.json { render :json => @log }
			else
				format.html { render :action => "new" }
				format.json { render :json => @log.errors, :status => :unprocessable_entity }
			end
		end
	end

	private
		def find_mission
			@mission = Mission.find(params[:mission_id])
		end
end
