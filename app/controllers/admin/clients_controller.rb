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
    @clients = Client.all
    # 件数
    @total_count   = Client.all.count
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
    if @client.save
      redirect_to action: :index
    else
      render action: :form
    end
  end

  # updateアクション
  def update
    if @client.update(client_params)
      redirect_to action: :index
    else
      render action: :form
    end
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      redirect_to action: :index if @client.destroy
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
