module ApplicationHelper
  def broadcast(channel, msg)
    message = {:channel => channel, :data => msg, :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("#{faye_url}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def faye_url()
    ENV['FAYE_URL'] || "http://#{request.host}:9292"
  end
end
