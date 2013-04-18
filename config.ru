# This file is used by Rack-based servers to start the application.
if (ENV['IM_FAYE']) then
  require 'faye'
  require File.expand_path('../config/initializers/faye_token.rb', __FILE__)

  class ServerAuth
    def incoming(message, callback)
      if message['channel'] !~ %r{^/meta/}
        if message['ext']['auth_token'] != FAYE_TOKEN
          message['error'] = 'Invalid authentication token'
        end
      end
      callback.call(message)
    end

    # IMPORTANT: clear out the auth token so it is not leaked to the client
    def outgoing(message, callback)
      if message['ext'] && message['ext']['auth_token']
        message['ext'] = {}
      end
      callback.call(message)
    end
  end

  Faye::WebSocket.load_adapter('thin')

  faye = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
  faye.add_extension(ServerAuth.new)
  run faye

else
  require ::File.expand_path('../config/environment',  __FILE__)
  run Puck::Application
end
