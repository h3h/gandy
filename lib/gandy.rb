require 'gandy/version'

module Gandy
  def self.print(string, mode=:info)
    if string.respond_to?(:red)
      puts case mode
      when :info
        string.light_blue
      when :error
        string.red
      when :warn
        string.yellow
      end
    else
      puts "[#{mode}] #{string}"
    end
  end
end

require 'gandy/railtie'     if defined?(Rails)
require 'gandy/installer'
