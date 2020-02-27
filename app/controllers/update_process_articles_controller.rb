class UpdateProcessArticlesController < ApplicationController
  before_action :set_update_process_article, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @update_process_articles = UpdateProcessArticle.all
    respond_with(@update_process_articles)
  end

  def show
    respond_with(@update_process_article)
  end

  def new
    @update_process_article = UpdateProcessArticle.new
    respond_with(@update_process_article)
  end

  def edit
  end

  def create

    @update_process_article = UpdateProcessArticle.new(update_process_article_params)
    @updated, @failed = Article.update_article_blocks update_process_article_params
    @update_process_article[:updated]  = @updated
    @update_process_article[:failed]  = @failed

    @update_process_article.save
    respond_with(@update_process_article)
  end

  def update
    @update_process_article.update(update_process_article_params)
    respond_with(@update_process_article)
  end

  def destroy
    @update_process_article.destroy
    respond_with(@update_process_article)
  end

  private
    def set_update_process_article
      @update_process_article = UpdateProcessArticle.find(params[:id])
    end

    def update_process_article_params
      params.require(:update_process_article).permit(:supplier_id, :updated, :failed, :user_id, :percentage)
    end
end
