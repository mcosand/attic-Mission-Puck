module ApplicationHelper
  def faye_url()
    ENV['FAYE_URL'] || "http://#{request.host}:9292"
  end
end
