# == Schema Information
#
# ロール
#
# name          名前   :string(20)     not null
# explanation   説明   :text           
#
class Admin::RolesController < ApplicationController
  before_action :set_role, only: [:edit, :update, :destroy]

  # indexアクション
  def index
    @roles = Role.all
    # 件数
    @total_count   = @roles.count
  end

  # newアクション
  def new
  end

  # editアクション
  def edit
    render action: :form
  end

  # createアクション
  def create
    ActiveRecord::Base.transaction do
      @role = Role.new(role_params)
      # アカウントの作成・保存
      return render action: 'form' if @role.invalid?
      @role.save!
    end
    redirect_to action: :index
  end

  # updateアクション
  def update
    if @role.update(role_params)
      redirect_to action: :index
    else
      render action: :form
    end 
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      redirect_to action: :index if @role.destroy
    end
  end

  # 子テーブル(user)アクション
  # /admin/roles/:id/users
  def users
    @role_id = params[:id]
    # 子要素(ユーザー)
    @users  = User.where(role_id: @role_id)
                  .includes(%i(client role))
  end

  # 子テーブル(menu)アクション
  # /admin/roles/:id/menus
  def menus
    @role_id = params[:id]
    # 子要素(メニュー)
    @menus  = Menu.where(role_id: @role_id)
  end

  # プライベートメソッド
  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :explanation)
    end

end
