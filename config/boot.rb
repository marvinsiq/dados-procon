require 'yaml'# Defines our constants

PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)
STOPWORDS = File.read('stopwords').split "\n"
COMPLAINT_PROBLEMS = case PADRINO_ENV
  when 'teste' then {1 => 'teste'}
  else YAML.load_file('.complaint_problems.yml') if File.exists? '.complaint_problems.yml'
end

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'yaml'
Bundler.require(:default, PADRINO_ENV)

##
# Enable devel logging
#
# Padrino::Logger::Config[:development] = { :log_level => :devel, :stream => :stdout }
# Padrino::Logger.log_static = true
#

# load project environment variables
YAML.load_file('.env').each {|k, v| ENV[k] = v }
  
##
# Add your before load hooks here
#
Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
