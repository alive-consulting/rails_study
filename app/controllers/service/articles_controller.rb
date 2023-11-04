# == Schema Information
#
# 記事
#
# title          タイトル     :string(100)    not null
# publish_date   公開日       :date           
# content        内容         :text           not null
# is_delete      削除         :boolean        
# is_confirmed   確認         :boolean        
# user_id        ユーザーID   :integer        
#
class Service::ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]

  # indexアクション
  def index
    @articles = Article.all
    @articles = @articles.where(user_id: params[:user_id]) if params[:user_id].present?
    # 件数
    @total_count   = Article.all.count
  end

  # newアクション
  def new
    @article = Article.new
    render action: :form    
  end

  # editアクション
  def edit
    render action: :form
  end

  # createアクション
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to action: :index
    else
      render action: :form
    end
  end

  # updateアクション
  def update
    if @article.update(article_params)
      redirect_to action: :index
    else
      render action: :form
    end
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      redirect_to action: :index if @article.destroy
    end
  end

  # プライベートメソッド
  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :publish_date, :content, :is_delete, :is_confirmed, :user_id)
    end

end
