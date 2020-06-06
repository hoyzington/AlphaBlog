class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]
  before_action :set_user, except:[:index, :new, :create]
  before_action :require_user, except:[:show, :index]
  before_action :admin_or_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully.'
      redirect_to user_path(@article.user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to user_path(@article.user)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_user
    @user = @article.user
  end

  def article_params
    params.require(:article).permit(:title, :content, category_ids: [])
  end

end
