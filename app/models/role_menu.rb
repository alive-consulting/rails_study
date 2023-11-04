# == Schema Information
#
# ロール(roles)とメニュー(menus)のN:Nアソシエーション用モデル
#
class RoleMenu < ApplicationRecord
  belongs_to :role
  belongs_to :menu
end
