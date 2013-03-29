class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

	def check_for_mobile
		session[:mobile_override] = params[:mobile] if params[:mobile]
		prepare_for_mobile if mobile_device?
	end

	def prepare_for_mobile
		prepend_view_path Rails.root + 'app' + 'views_mobile'
	end

	def mobile_device?
    logger.info("User agent: #{request.user_agent}")
    if params[:mobile_once]
      true
		elsif session[:mobile_override]
			session[:mobile_override] == "1"
		else
			(request.user_agent =~ /Mobile|webOS|iPad/)
		end
	end
	helper_method :mobile_device?
end
