class PicturesController < ApplicationController
  def index
  	# The following two lines use the pictures_params
  	# listingId = picture_params[:listing_id]
  	# @listing = Listing.find(listingId)
    @user = User.find(params[:user_id])
  	@listing = @user.listings.find(params[:listing_id])
  	@pictures = @listing.pictures
  end

  def new
  	@user = User.find(params[:user_id])
    @listing = @user.listings.find(params[:listing_id])
  	@picture = Picture.new(:listing => @listing)
  end

  def create
    @user = User.find(params[:user_id])
  	listingId = params[:listing_id]
  	@listing = @user.listings.find(listingId)

  	@picture = Picture.new(picture_params)

  	@picture.listing = @listing

  	uploadIO = params[:picture][:image]

  	if uploadIO != nil
  		t = Time.now
  		ext = File.extname(uploadIO.original_filename)
  		tmpFilename = "file_#{t.strftime("%Y%m%d%H%M")}" + ext
  		@picture.filename = tmpFilename
  		filename = Rails.root.join('public', 'images', tmpFilename)

  		# Save the file
  		# w to write
  		# b to overwrite
  		File.open(filename, 'wb') do |file|
  			file.write(uploadIO.read)
  		end

  		if @picture.save
  			redirect_to listing_pictures_path
  		else
  			render 'new'
  		end
  	end

  end

  def edit
    @user = User.find(params[:user_id])
  	@listing = @user.listings.find(params[:listing_id])
  	@picture = @listing.pictures.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    listingId = params[:listing_id]
    @listing = @user.listings.find(listingId)

    @picture = @listing.pictures.find(params[:id])
    uploadIO = params[:picture][:image]

    if uploadIO != nil
      if @picture.filename != nil
        filename = Rails.root.join('public','images', @picture.filename)
        File.delete(filename) if File.exists?(filename)
      end
      t = Time.now
      ext = File.extname(uploadIO.original_filename)
      tmpFilename = "file_#{t.strftime("%Y%m%d%H%M")}" + ext
      @picture.filename = tmpFilename
      filename = Rails.root.join('public', 'images', tmpFilename)

      # Save the file
      # w to write
      # b to overwrite
      File.open(filename, 'wb') do |file|
        file.write(uploadIO.read)
      end
    end

    if @picture.update(picture_params)
      redirect_to listing_pictures_path(@listing)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
  	listingId = params[:listing_id]
    listing = @user.listings.find(listingId)

    picture = listing.pictures.find(params[:id])

    if picture.filename != nil
      filename = Rails.root.join('public','images', picture.filename)
      File.delete(filename) if File.exists?(filename) 
    end
    
    listing.pictures.destroy(picture)
    redirect_to user_listing_pictures_path(@user,listing)
  end

  def show
    @user = User.find(params[:user_id])
    listingId = params[:listing_id]
    @listing = @user.listings.find(listingId)

    @picture = @listing.pictures.find(params[:id])
  end

# parameters whitelist 
  private
  def picture_params
    params.require(:picture).permit(:user_id, :listing_id, :title)  	 	
  end  
end
