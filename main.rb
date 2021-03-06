# SEI Project 2 - David McDonald
# Homechekr App

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'
require_relative 'domain_api'
require_relative 'models/property'
require_relative 'models/comment'
require_relative 'models/user'


enable :sessions


helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end


after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end


get '/login' do
  erb :login
end


post '/session' do
  user = User.find_by(email: params[:email].downcase)
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/properties'
  else
    erb :login
  end
end


delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end


get '/properties' do
  @properties = Property.where(user_id: current_user.id)
  erb :properties
end


get '/properties/new' do
  redirect '/login' unless logged_in?
  # get params from find
  @domain_id = params[:domain_id]
  @address = params[:address]

  erb :new
end


post '/properties' do
  property = Property.new
  property.address = params[:address]
  property.main_img = params[:main_img]
  property.property_type = params[:property_type]
  property.bed_count = params[:bed_count]
  property.bath_count = params[:bath_count]
  property.car_space_count = params[:car_space_count]
  property.notes_general = params[:notes_general]
  property.user_id = current_user.id

  property.save
  redirect '/properties'
end


get '/properties/search' do
  @properties = Property.where(user_id: current_user.id).where("address ilike '%#{params[:search]}%'")
  erb :properties
end


get '/properties/find' do
  erb :find
end



# search domain for property
get '/properties/find/results' do
  @search_address = params[:search_address]
  puts @search_address

  @api_data = DomainAPI.get_access_token()
  @results = DomainAPI.get_resi_properties_by_terms(params[:search_address],@api_data["access_token"])

  erb :findresults
end





get '/properties/:id' do
  @property = Property.find(params[:id])
  @comments = Comment.where(property_id: @property.id)
  erb :show
end


delete '/properties/:id' do
  property = Property.find(params[:id])
  property.delete
  redirect "/properties"
end


get '/properties/:id/edit' do
  @property = Property.find(params[:id])
  erb :edit
end


put '/properties/:id' do
  property = Property.find(params[:id])
  property.address = params[:address]
  property.main_img = params[:main_img]
  property.notes_general = params[:notes_general]

  property.save
  redirect "/properties/#{property.id}"
end



post '/comments' do
  comment = Comment.new
  comment.content = params[:content]
  comment.property_id = params[:property_id]
  comment.save
  redirect "/properties/#{comment.property_id}"
end


get '/signup' do
  erb :signup
end


post '/signup' do
  user = User.new
  user.first_name = params[:first_name]
  user.last_name = params[:last_name]
  user.email = params[:email].downcase
  user.password = params[:password]
  user.save
  session[:user_id] = user.id
  redirect '/'
end





