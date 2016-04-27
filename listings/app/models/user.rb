class User < ActiveRecord::Base
  has_secure_password

  has_many :listings, dependent: :destroy

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  
   # Dont validate presence, because an admin will not provide the user's password, just do validation of length
  validates :password, length: {minimum: 8}, allow_nil: true
  validates :usertype, presence: true

  # Method overwriting 
  def to_s
    "#{firstname}" + " " + "#{lastname}"
  end
end
