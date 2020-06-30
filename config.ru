require './config/environment'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
    enable :sessions
    register Sinatra::Flash
# if ActiveRecord::Migrator.needs_migration?
#   # raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use UsersController
use BooksController  #mounting controllers

run ApplicationController
