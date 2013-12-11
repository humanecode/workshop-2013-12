class User < ActiveRecord::Base
  has_secure_password

  def self.authenticate email, password
    user = find_by_email email
    if user && user.authenticate(password)
      user
    else
      Invalid.new email
     end
   end
end
