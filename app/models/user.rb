class User < ActiveRecord::Base
  # Reference document: http://bcrypt-ruby.rubyforge.org/
  include BCrypt

# DON'T INCLUDE THIS LINE; COPIED FROM STACK OVERFLOW EXAMPLE
# IT CAUSES MOST OF THE DATA TO BE BLANK RATHER THAN GETTING
# IT FROM PARAMS...
  # attr_accessor :name, :email, :password

# the following validations all work except for password presence
# Have to watch bash shell for the errors unless using create! in 
# the controller
  validates :name, :email, :password, presence: true
  validates :name, :email, uniqueness: true
  validates :password, length: { minimum: 6 }

   # => { message: "Enter name" }
  #                  :uniqueness => { message: "Must be unique"}
  #                  # :length     => { :within => 2..10 }     

# stealing thunder line 23 if password_hash and 
# lines 31-35 self_authenticate method
  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

# This was copy pasta from thunder but the hash representing the user logging
# in is in a different format than the hash representing the new user
# it's {"email"=>"123@123.com", "password"=>"123"} vs
# {"user"=>{"name"=>"fdsafd", "email"=>"asdf@fdas.com", "password"=>""}}
#   def self.authenticate(user)
#     user = User.find_by_email(user[:email])
#     return false unless user && user.password == user[:password]
#     user
#   end

end
