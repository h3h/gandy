require 'gandy'
require 'rails'

module Gandy
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../../tasks/gandy.rake', __FILE__)
    end
  end
end
