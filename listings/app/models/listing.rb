class Listing < ActiveRecord::Base
	validates :title, presence: true
	belongs_to :user
	# validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
	has_many :features, dependent: :destroy
	has_many :pictures, dependent: :destroy
end
