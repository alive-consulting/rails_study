# == Schema Information
#
# ユーザー
#
# name                    名前           :string(20)     not null
# client_id               顧客ID         :integer        not null
# role_id                 ロールID       :integer        not null
# is_deposit_prohibited   入金禁止       :boolean        default(0)
# locale                  ロケール       :string(2)      
#
class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # indexアクション
  def index
    @users = User.all
    # 件数
    @total_count   = @users.count
  end

  # newアクション
  def new
    @user = User.new
    render action: :form
  end

  # editアクション
  def edit
    render action: :form
  end

  # createアクション
  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)
      # アカウントの作成・保存
      return render action: 'form' if @user.invalid?
      @user.save!
    end
    redirect_to action: :index
  end

  # updateアクション
  def update
    if @user.update(user_params)
      redirect_to action: :index
    else
      render action: :form
    end        
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      redirect_to action: :index if @user.destroy
    end
  end

  # プライベートメソッド
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :client_id, :role_id, :is_deposit_prohibited, :locale, :password, :password_confirmation)
    end
end
