require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra/activerecord'
require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'sinatra'
require 'pg'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

ActiveRecord::Base.establish_connection("postgres://postgres:danladi@localhost:5433/postgres")

# require 'yaml'
# db_config = YAML.load(File.read('config/database.yml'))
# ActiveRecord::Base.establish_connection db_config['email_development']

class User < ActiveRecord::Base
  validates :email, 
            :name, 
            :presence => {:message => "must be set"}, 
            :uniqueness => {:message => "must be unique"}
  validates :email, :name, 
  :presence => {:message => "must be set"}, 
  :uniqueness => {:message => "must be unique"}
end

get '/' do
  erb :home
end

post '/' do
  if request.xhr?
    # here is where you would respond and tell it not to render a template and just send some JSON
  else
    @user = User.new(params[:user])
    @errors = @user.errors.full_messages unless @user.save
    erb :home
  end
end
