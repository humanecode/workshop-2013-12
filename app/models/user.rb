class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def self.authenticate email, password
    user = find_by_email email
    if user && user.authenticate(password)
      user
    else
      Invalid.new email
     end
   end
end
