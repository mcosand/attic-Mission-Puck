class HomeController < ApplicationController
	def index
		broadcast "/logs/new", "This is a message"
	end
end
