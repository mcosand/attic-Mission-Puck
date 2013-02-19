class LogsController < ApplicationController
	before_filter :find_mission

	def index
		@logs = @mission.logs.all
	end

	private
		def find_mission
			@mission = Mission.find(params[:mission_id])
		end
end
