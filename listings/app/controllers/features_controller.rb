class FeaturesController < ApplicationController
  def index
  	@user = User.find(params[:user_id])
    listingId = params[:listing_id]
  	@listing = @user.listings.find(listingId)
  	@features = @listing.features
  end

  def new
  	@user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:listing_id])
    @feature = Feature.new(:listing=>@listing)
  end

  def create
    @user = User.find(params[:user_id])
    listingId = params[:listing_id]
    @listing = @user.listings.find(listingId)

    @feature = Feature.new(features_params)

    @feature.listing = @listing

    if @feature.save
      redirect_to user_listing_features_path
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:listing_id])
    @feature = @listing.features.find(params[:id])
  end

  def update
  	@user = User.find(params[:user_id])
    listingId = params[:listing_id]
    @listing = @user.listings.find(listingId)

    @feature = @listing.features.find(params[:id])

    if @feature.update(features_params)
      redirect_to user_listing_features_path
    else
      render 'edit'
    end
  end

  def destroy
  	@user = User.find(params[:user_id])
    listingId = params[:listing_id]
    listing = @user.listings.find(listingId)

    feature = listing.features.find(params[:id])
    
    listing.features.destroy(feature)
    redirect_to user_listing_features_path(@user,listing)
  end

  private
  def features_params
    params.require(:feature).permit(:user_id, :listing_id, :description)  	 	
  end  	 

end