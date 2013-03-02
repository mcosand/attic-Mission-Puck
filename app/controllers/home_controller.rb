class HomeController < ApplicationController
	before_filter :check_for_mobile

	def index
		@activeMission = Mission.order(:started).last
	end

	def setSystemTime
		date = params[:id].to_i
		status = 422
		if (date > 631180800)
			`sudo date --set=@#{date}`
			status = 200
		end
		render :nothing => true, :status => status, :content_type => 'text/html'
	end
end
