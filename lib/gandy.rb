require 'colorize'
require 'gandy/version'

module Gandy
  def self.print(string, mode=:info)
    if string.respond_to?(:red)
      puts case mode
      when :error
        string.red
      when :warn
        string.yellow
      when :success
        string.green
      else
        string.light_blue
      end
    else
      puts "[#{mode}] #{string}"
    end
  end
end

require 'gandy/railtie'     if defined?(Rails)
require 'gandy/installer'
