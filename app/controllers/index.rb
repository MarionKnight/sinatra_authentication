enable :sessions

get '/' do
  p "I made it home!"
  # render home page
  erb :index
   #TODO: Show all users if user is signed in
end

get '/themostawesomepage' do
  if current_user
    "this is the most awesomest page"
  else
    redirect '/'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  p "*"*100
  p params
  # sign-in .. todo: refactor: change my_user to @user
  my_user = User.find_by_email( params[:email] )
  # This is the line that logs the user in
  # There is no checking yet...
  session[:user_id] = my_user.id
  p session
  p "Hi I'm user##{current_user}"
  # auth testing to start here...
  p ":-).."*200
  p my_user.password
  p my_user.password_hash
  p params[:password]
  p my_user.password_hash == "111"
  p my_user.password_hash == params[:password]
  redirect '/'
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  # copied the next line from stack overflow 4252800
  session.clear
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
  the_current_user = User.create({
    :name => params["user"]["name"],
    :email => params["user"]["email"],
    :password => params["user"]["password"]
  })
  puts the_current_user.errors.messages
  erb :sign_in

  # The next stuff is me trying to get password length validations and 
  # validation error messages to show up in the route in a user friendly way...
  # I think I need to create some additional routes to display them nicely...
  # p user.errors.messages

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
