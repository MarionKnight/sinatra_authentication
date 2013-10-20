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
  # puts params["user"]["name"]  ... returns the user's name
  # puts params[:user] == params["user"] ... returns true
  # long format for hash in a hash in ruby, which activerecord uses to create users
  # {"user"=>{"name"=>"fdsafd", "email"=>"asdf@fdas.com", "password"=>""}}
  # This next one, when used, doesn't store name, email until password stuff
  # gets donefrom the /user route
  # User.create({:name => "Me", :email => "my_email", :password => "my_pass"})
  # As long as I use create! at least false validations give indication...
  current_user = User.create({
    :name => params["user"]["name"],
    :email => params["user"]["email"],
    :password => params["user"]["password"]
  })
  puts current_user.errors.messages

  # The next stuff is me trying to get password length validations and 
  # validation error messages to show up in the route in a user friendly way...
  # But I gave up for now and need help...
  # 
  # user = User.new({
  #   :name => params["user"]["name"],
  #   :email => params["user"]["email"],
  #   :password => params["user"]["password"]
  # })
  # p user.errors.messages
  # puts user.errors.messages

  # Found this code on internet but it doesn't work for me...
  # http://stackoverflow.com/questions/10150800/rails-how-to-validate-password-from-input-if-there-is-not-password-field-in-dat
  # not sure why they are redefining active record create method
  # according to activerecord docs, validations are not run when using new
  #
  # def create
  #   @user = User.new(params["user"])
  #   @user.save
  #   # if @user.save
  #   #   reedirect_to controller: 'users', action: '/users'
  #   # else
  #   #   render 'sign_up'
  #   # end
  # end
  # User.create

end
