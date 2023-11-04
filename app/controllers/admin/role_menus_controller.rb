
# == Schema Information
#
# ロール(roles)とメニュー(menus)のN:Nリレーション
#
class Admin::RoleMenusController < ApplicationController
  before_action :role_menu_params, only: [:update]

  #
  # editアクション
  #
  def edit
    # ロールの取得
    @role = Role.find(params[:role_id])
    # ロールとメニューのリレーション情報を取得
    @role_menus = Menu.joins('
      LEFT JOIN role_menus
      ON  role_menus.role_id          = ' + params[:role_id] + '
      AND role_menus.menu_id = menus.id
    ').select('
      menus.id AS menu_id
     ,menus.*
     ,role_menus.id AS role_menus_id
    ').order('menu_id').all
    # 件数
    @total_count   = Menu.all.count
  end

  #
  # updateアクション
  # @note
  # パラメータは以下のように入って来ます。
  # 'role'の中のハッシュは{'menu_id'=>'チェック状態'}を表します。
  #
  # Parameters: {'utf8'=>'?', 'authenticity_token'=>'[FILTERED]', 'button'=>'',
  # 'role'=>{'1'=>'1', '2'=>'0', '3'=>'1', '4'=>'0'}, 'role_id'=>'1'}
  #
  def update
    # DELETE INSERTでN:Nアソシエーションテーブルを再構築
    RoleMenu.transaction do
      # ロールメニューアソシエーションの削除
      RoleMenu.where(role_id: params[:role_id]).delete_all
      # チェックが入ったもののみ登録
      params[:role].each do |param|
        role_menu = RoleMenu.new
        # param[1]はチェック状態
        if param[1] == '1'
          # メニューIDはparam[0]
          role_menu.menu_id = param[0]
          # ロールID
          role_menu.role_id = params[:role_id]
          role_menu.save!
        end
      end
    end
    redirect_to action: :edit
  end

  #
  # プライベートメソッド
  # @note
  # ストロングパラメータにmenu_idの配列があるので組み込んでいます。
  #
  private
    def role_menu_params
      params.require(:role).permit(:role_id, :role, Menu.pluck(:id).map(&:to_s))
    end
end    
