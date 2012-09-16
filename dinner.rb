require 'sinatra'

$food = ['chocolate', 'tv dinner', 'cereal', 'hot dogs', 'veal', 'pizza']

def dinner
  $food[rand($food.size)]
end

get '/dinner' do
  erb :index, locals: { dinner: dinner }
end

get '/add_dinner' do
  erb :new, locals: { food: $food }
end

post '/add_dinner' do
  $food << params[:dinner]
  redirect to('/add_dinner')
end
