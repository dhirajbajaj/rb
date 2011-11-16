class CategoryController < ApplicationController
  def index
		 @category = Category.all
		 # @category = Category.where("cat_name like ?", "%#{params[:q]}%")
		respond_to do |format|
		  format.html
		  format.json { render :json => @category.collect {|author| {:id => author.id, :name => author.cat_name } } }
		  # format.json { render :json => @category.map(&:attributes) }
		end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
	
    respond_to do |format|
      if @category.save
		format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.js  
      end
    end
  end



end
