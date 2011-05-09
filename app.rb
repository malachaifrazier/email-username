require 'rubygems'
require 'bundler'
Bundler.require
require 'active_record'
require 'sinatra'

require 'yaml'
db_config = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection db_config['development']

class User < ActiveRecord::Base
  validates :email, :username, :presence => {:message => "must be set"}, :uniqueness => {:message => "must be unique"}
end

get '/' do
  haml :home
end

post '/' do
  if request.xhr?
    # here is where you would respond and tell it not to render a template and just send some JSON
  else
    @user = User.new(params[:user])
    @errors = @user.errors.full_messages unless @user.save
    haml :home
  end
end
