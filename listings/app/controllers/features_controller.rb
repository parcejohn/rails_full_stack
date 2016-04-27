class FeaturesController < ApplicationController
  def index
  	@user = User.find(params[:user_id])
    listingId = params[:listing_id]
  	@listing = @user.listings.find(listingId)
  	@features = @listing.features
  end

  def new
  	
  end

  def create

  end

  def edit

  end

  def update
  	
  end

  def destroy
  	
  end

  private
  def features_params
    params.require(:feature).permit(:user_id, :listing_id, :description)  	 	
  end  	 

end
