get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
	# puts params
  # p params
  # puts params["user"]
  # puts params["user"]["name"]
  User.create! ({
    :name => params["user"]["name"],
    :email => params["user"]["email"],
    :password => params["user"]["password"]
    })

	# {"user"=>{"name"=>"fdsafd", "email"=>"asdf@fdas.com", "password"=>""}}
	# long format for hash in a hash in ruby, which activerecord uses to create users

end
