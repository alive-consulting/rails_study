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
    @q        = Article.ransack(search_params)
    @articles = @q.result(distinct: true).page(params[:page]).per(params[:per])
                  .includes(%i(user))
    @articles = @articles.where(user_id: params[:user_id]) if params[:user_id].present?

    # 件数
    @total_count   = Article.all.count
    @unconfirmed_count = Article.where.not(is_confirmed: true).all.count
    respond_to do |f|
      f.html
      f.json { render json: @articles }
    end
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
    set_user_id @article   # セッションからuser_id設定
    respond_to do |f|
      if @article.save
        f.html { redirect_to action: :index }
        f.json { render json: @article }
      else
        f.html { render action: :form, status: :unprocessable_entity }
        f.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # updateアクション
  def update
    set_user_id @article   # セッションからuser_id設定
    respond_to do |f|
      if @article.update(article_params)
        f.html { redirect_to action: :index }
        f.json { render json: @article }
      else
        f.html { render action: :form, status: :unprocessable_entity }
        f.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      respond_to do |f|
        if @article.destroy
          f.turbo_stream
          f.json { render json: @article }
        else
          f.turbo_stream
          f.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
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
