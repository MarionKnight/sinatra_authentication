class User < ActiveRecord::Base
  # Reference document: http://bcrypt-ruby.rubyforge.org/
  include BCrypt

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

  def self.authenticate(login_params)
    user = User.find_by_email(login_params[:email])
    return false unless user && user.password == login_params[:password]
    user
  end

end
