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
  		redirect_to user_listings_path
  	else
		  render "new"	
  	end
  end

  def edit
  	@user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:id])
  end

  def update
  	@user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:id])

    if @listing.update(listing_params)
      redirect_to user_listings_path(@user)
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    listing = @user.listings.find(params[:id])
    
    @user.listings.destroy(listing)
    redirect_to user_listings_path(@user)
  end

  private
  def listing_params
  	params.require(:listing).permit(:user_id, :title, :description, :price)
  end
end