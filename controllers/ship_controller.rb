require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry-byebug')
require_relative( '../models/ship.rb' )
require_relative( '../models/owner.rb' )
also_reload( '../models/*' )

get '/ship' do
  # binding.pry
  @ships = Ship.all
  @capacity = Ship.capacity
  erb (:"ship/index")
end

get '/ship/new' do
  @capacity = Ship.capacity
    if @capacity == 10
      redirect to '/ship'
    end
  @owners = Owner.all
  erb(:"ship/new")
end

get '/ship/:id' do
  @ship = Ship.find(params[:id].to_i)
  erb(:"ship/show")
end

post '/ship' do
  @ship = Ship.new(params)
  # binding.pry
  @ship.save
  erb(:"ship/create")
end

post '/ship/:id/delete' do
  ship = Ship.find(params[:id].to_i)
  ship.delete
  redirect to '/ship'
end

get '/ship/:id/edit' do
  @ship = Ship.find(params[:id].to_i)
  @owners = Owner.all
  erb(:"ship/edit")
end

post '/ship/:id' do
  Ship.new( params ).update
  redirect to '/ship'
end
