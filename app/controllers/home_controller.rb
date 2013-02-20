class HomeController < ApplicationController
	def index
		@activeMission = Mission.order(:started).last
	end
end
