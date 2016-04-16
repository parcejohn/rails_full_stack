class Listing < ActiveRecord::Base
	validates :title, presence: true
	# validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
	has_many :features, dependent: :destroy
	has_many :pictures, dependent: :destroy
end
