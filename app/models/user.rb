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

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
