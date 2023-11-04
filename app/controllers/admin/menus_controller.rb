# == Schema Information
#
# メニュー
#
# parent_id       親ID           :integer        
# child_id        子ID           :integer        
# logical_name    論理名         :string(100)    
# physical_name   物理名         :string(100)    
# url             URL            :string(100)    
# display_order   表示順         :integer        
# is_show         メニュー表示   :boolean        not null,default(1)
#
class Admin::MenusController < ApplicationController
  before_action :set_menu, only: [:edit, :update, :destroy]

  # indexアクション
  def index
    @menus        = Menu.all
    # 件数
    @total_count   = Menu.all.count
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
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to action: :index
    else
      render action: :form, status: :unprocessable_entity
    end
  end

  # updateアクション
  def update
    if @menu.update(menu_params)
      redirect_to action: :index
    else
      render action: :form, status: :unprocessable_entity
    end
  end

  # destroyアクション
  # TODO: 削除処理について要確認
  def destroy
    ActiveRecord::Base.transaction do
      redirect_to action: :index if @menu.destroy
    end
  end

  # プライベートメソッド
  private
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:parent_id, :child_id, :logical_name, :physical_name, :url, :display_order, :is_show)
    end

end
