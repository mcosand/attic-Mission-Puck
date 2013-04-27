class ApplicationController < ActionController::Base
  protect_from_forgery

  attr_accessor :enable_broadcast

  def broadcast(channel, msg)
    if (self.enable_broadcast == nil || self.enable_broadcast == true) then

      message = {:channel => channel, :data => msg, :ext => {:auth_token => FAYE_TOKEN}}
      uri = URI.parse("#{ENV['FAYE_URL'] || 'http://localhost:9292'}/faye")

      response = Net::HTTP.post_form(uri, :message => message.to_json)

      result = JSON.parse(response.body).first
      raise "FAYE ERROR: #{result['error']}" unless result['successful']
    end
  end

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
