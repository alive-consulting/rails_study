# == Schema Information
#
# 顧客
#
# name   顧客名   :string(20)     not null
#
class Client < ApplicationRecord
  # REVIEW: データ削除時は子データにも気をつけて下さい。
  #  子データ削除したい　→　dependent: :destroy
  #  子データ残したい　　→　dependent: :nullify
  # をモデルのhas_xxxxに記載。

  # アソシエーション
  has_many :users, dependent: :nullify

  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }

  # TODO:検索ソートに組み入れない項目は下記の配列から除外すること
  def self.ransackable_attributes (auth_object = nil)
    %w(name)
  end
end
