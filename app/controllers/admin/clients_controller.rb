# == Schema Information
#
# 顧客
#
# name   顧客名   :string(20)     not null
#
class Admin::ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]

  # indexアクション
  def index
    @q        = Client.ransack(search_params)
    @clients = @q.result(distinct: true).page(params[:page]).per(params[:per])

    # 件数
    @total_count   = Client.all.count
    respond_to do |f|
      f.html
      f.json { render json: @clients }
    end
  end

  # newアクション
  def new
    @client = Client.new
    render action: :form
  end

  # editアクション
  def edit
    render action: :form
  end

  # createアクション
  def create
    @client = Client.new(client_params)
    respond_to do |f|
      if @client.save
        f.html { redirect_to action: :index }
        f.json { render json: @client }
      else
        f.html { render action: :form, status: :unprocessable_entity }
        f.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # updateアクション
  def update
    respond_to do |f|
      if @client.update(client_params)
        f.html { redirect_to action: :index }
        f.json { render json: @client }
      else
        f.html { render action: :form, status: :unprocessable_entity }
        f.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end        
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      respond_to do |f|
        if @client.destroy
          f.turbo_stream
          f.json { render json: @client }
        else
          f.turbo_stream
          f.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # 子テーブル(user)アクション
  # /admin/clients/:id/users
  def users
    @client_id = params[:id]
    # 子要素(ユーザー)
    @users  = User.where(client_id: @client_id)
                  .includes(%i(client role))
  end

  # プライベートメソッド
  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name)
    end

end
