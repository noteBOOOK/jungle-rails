class User < ActiveRecord::Base

  has_secure_password


  def self.authenticate_with_credentials email, password
    filtered_email = email.downcase.strip
    @user = User.find_by_email(filtered_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 4}
  validates :password_confirmation, presence: true, length: {minimum: 4}
  
end
