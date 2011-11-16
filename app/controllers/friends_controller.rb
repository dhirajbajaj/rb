class FriendsController < ApplicationController
  def index
  	 	@friends = current_user.friend.where("name like ?", "%#{params[:q]}%")
		respond_to do |format|
		  format.html
		  format.json { render :json => @friends.map(&:attributes) }
		  # format.json { render :json => @category.map(&:attributes) }
		end
  end

  def show
    @friend = Friend.find(params[:id])
  end

  def new
    @friend = current_user.friend.new
	respond_to do |format|
      format.html 
      format.js
    end
  end

  def create
    @friend = current_user.friend.new(params[:friend])
    respond_to do |format|
      if @friend.save
		@friends = current_user.friend.all
		@expenditures = current_user.expenditure.order("date DESC")
		format.html { redirect_to(@friends, :notice => 'Friend created.') }
        format.js
    else
        format.html { render :action => "new" }
        format.js  
    end
  end
	
  end

  def edit
    @friend = Friend.find(params[:id])
  end

  def update
    @friend = Friend.find(params[:id])
    if @friend.update_attributes(params[:friend])
      redirect_to @friend, :notice  => "Successfully updated friend."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_url, :notice => "Successfully destroyed friend."
  end
end
