# == Schema Information
#
# ロール
#
# name          名前   :string(20)     not null
# explanation   説明   :text           
#
class Role < ApplicationRecord
  # REVIEW: データ削除時は子データにも気をつけて下さい。
  #  子データ削除したい　→　dependent: :destroy
  #  子データ残したい　　→　dependent: :nullify
  # をモデルのhas_xxxxに記載。

  # アソシエーション
  has_many :users, dependent: :nullify
  # menusとN:Nアソシーエーション
  has_many :role_menus, dependent: :destroy
  has_many :menus, through: :role_menus, dependent: :delete_all

  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :explanation, length: { maximum: 65535 } 

  # TODO:検索ソートに組み入れない項目は下記の配列から除外すること
  def self.ransackable_attributes (auth_object = nil)
    %w(name explanation)
  end
end
