require 'sidekiq/testing' 

RSpec.configure do |c|
  c.before { Sidekiq::Worker.clear_all }  
end