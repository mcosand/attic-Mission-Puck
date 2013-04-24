# Some of the Commands reflect into the model types. The types must be loaded before this will work
Dir.glob(Rails.root.to_s + '/app/models/*.rb').each { |f| require f }
