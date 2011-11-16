class ExpendituresController < ApplicationController
  # can_edit_on_the_spot
  
  # GET /expenditures
  # GET /expenditures.json
  # before_filter :check_authorization
  before_filter :authenticate_user!
  def index
    # @expenditures = expenditure.order("date DESC")
    @expenditures = current_user.expenditure.order("date DESC")
    # @expenditure = current_user.expenditure.new
	@thumb = current_user.current_thumb(session[:currauth]);
    @friends = current_user.friend.all
	@total = @expenditures.sum('amount')
	# @spenders = current_user.expenditure.group(:spender_name).sum(:amount)
	# @category = current_user.expenditure.includes(:category).group("categories.cat_name").sum(:amount);

    # @category = Category.select('DISTINCT cat_name')

	respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @expenditures }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    @expenditure = current_user.expenditure.find(params[:id])
	respond_to do |format|
	  format.html # show.html.erb
	  format.json  { render :json => @expenditure }
	end
  end

  # GET /expenditures/new
  # GET /expenditures/new.json
  def new
    @expenditure = current_user.expenditure.new
    @friends = current_user.friend.all
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /expenditures/1/edit
  def edit
    @expenditure = Expenditure.find(params[:id])
    @friends = current_user.friend.all
  end

  # POST /expenditures
  # POST /expenditures.json
  def create
	@target = params[:expenditure][:spender_name]!="" ? params[:expenditure][:spender_name] : "me";
	if(@target == "me")
		@expenditure = current_user.expenditure.new(params[:expenditure])
		@expenditure.user_id = current_user.id
		@expenditure.setDefaultVal(params[:expenditure][:spender_name],params[:expenditure][:dir])
		respond_to do |format|
		  if @expenditure.save
			@expenditures = current_user.expenditure.order("date DESC")
			@total = current_user.expenditure.sum('amount')
			format.html { redirect_to(@expenditure, :notice => 'Expenditure was successfully created.') }
			format.js
			# respond_with(@expenditure)
		  else
			format.html { render :action => "new" }
			format.js
		  end
		end
	else
		@friend = current_user.friend.find(@target);
		@expenditure = @friend.expenditure.new(params[:expenditure])
		@expenditure.setDefaultVal(params[:expenditure][:spender_name],params[:expenditure][:dir])
		respond_to do |format|
		  if @expenditure.save
			@expenditures = @friend.expenditure.order("date DESC")
			@total = @friend.expenditure.sum('amount')
			format.html { redirect_to(@expenditure, :notice => 'Expenditure was successfully created.') }
			format.js
			# respond_with(@expenditure)
		  else
			format.html { render :action => "new" }
			format.js
		  end
		end
		# render :text => @target.to_yaml
	end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.json
  def update
    @target = params[:expenditure][:spender_name]!="" ? params[:expenditure][:spender_name] : "me";
	if(@target == "me")
		@expenditure = current_user.expenditure.find(params[:id])
		@expenditure.user_id = current_user.id
		@expenditure.setDefaultVal(params[:expenditure][:spender_name],params[:expenditure][:dir])
		respond_to do |format|
		  if @expenditure.update_attributes(params[:expenditure])
			@expenditures = current_user.expenditure.order("date DESC")
			@total = current_user.expenditure.sum('amount')
			format.html { redirect_to(@expenditure, :notice => 'Expenditure was successfully created.') }
			format.js
			# respond_with(@expenditure)
		  else
			format.html { render :action => "new" }
			format.js
		  end
		end
	else
		@friend = current_user.friend.find(@target);
		@expenditure = @friend.expenditure.find(params[:id])
		@expenditure.setDefaultVal(params[:expenditure][:spender_name],params[:expenditure][:dir])
		respond_to do |format|
		  if @expenditure.update_attributes(params[:expenditure])
			@expenditures = @friend.expenditure.order("date DESC")
			@total = @friend.expenditure.sum('amount')
			format.html { redirect_to(@expenditure, :notice => 'Expenditure was successfully created.') }
			format.js
			# respond_with(@expenditure)
		  else
			format.html { render :action => "new" }
			format.js
		  end
		end
		# render :text => @target.to_yaml
	end
end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy

    @target = params[:spender_id]
	@expenditure = Expenditure.find(params[:id])
	@expenditure.destroy
	if(@target == "me")
		# @expenditure = current_user.expenditure.find(params[:id])
		# @expenditure.destroy
		@total = current_user.expenditure.sum('amount')
		@expenditures = current_user.expenditure.order("date DESC")

		respond_to do |format|
		  format.html { redirect_to(@expenditure) }
		  format.js
		end
	else
		# @expenditure = @friend.expenditure.find(params[:id])
		# @expenditure.destroy
		@friend = current_user.friend.find(@target);
		@expenditures = @friend.expenditure.order("date DESC")
		@total = @friend.expenditure.sum('amount')
		respond_to do |format|
			format.html { redirect_to(@expenditure, :notice => 'Expenditure was successfully destroyed.') }
			format.js
		  end
		# render :text => @target.to_yaml
	end
  end

	def calculateTotal
		total = current_user.expenditure.sum('amount')
		return total
	end
end
