require 'sinatra'

$food = ['chocolate', 'tv dinner', 'cereal', 'hot dogs', 'veal', 'pizza']

get '/dinner' do
  erb :index, locals: {dinner: dinner}
end

get '/add_dinner' do
  erb :new, locals: {array: $food}
end

post '/add_dinner' do
  $food << params[:dinner]
  redirect to('/add_dinner')
end

def dinner
  $food[rand($food.size)]
end
