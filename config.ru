require 'rubygems'
require 'bundler'
require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'sinatra/redirect_with_flash'
Bundler.require

require 'sinatra'
require './app'

run Sinatra::Application

