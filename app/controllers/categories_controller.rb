class CategoriesController < ApplicationController
  
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "The #{@category.name} category has been created."
      redirect_to new_category_path
    else
      render "new"
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "This category is now called #{@category.name}."
      redirect_to @category
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Unauthorized Action."
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

end