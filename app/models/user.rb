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
class User < ApplicationRecord
  # アソシエーション
  belongs_to :role, optional: true
  belongs_to :client, optional: true

  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :client_id, presence: true
  validates :role_id, presence: true
  validates :locale, length: { maximum: 2 }

  # TODO:検索ソートに組み入れない項目は下記の配列から除外すること
  def self.ransackable_attributes (auth_object = nil)
    %w(name client_id role_id is_deposit_prohibited locale)
  end
end
