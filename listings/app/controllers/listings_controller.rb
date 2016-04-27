class ListingsController < ApplicationController

  before_action :logged_in
  
  def index
    @user = User.find(params[:user_id])
  	@listings = @user.listings.all
  end

  def new
    @user = User.find(params[:user_id])
  	@listing = Listing.new(:user=>@user)
  end

  def create
    @user = User.find(params[:user_id])
  	@listing = Listing.new(listing_params)
    @listing.user = @user
  	if @listing.save
  		redirect_to root_path
  	else
		  render "new"	
  	end
  end

  def edit
  	
  end

  def update
  	
  end

  def show
  	
  end

  def destroy
  end

  private
  def listing_params
  	params.require(:listing).permit(:user_id, :title, :description, :price)
  end
end
