# == Schema Information
#
# 記事
#
# title          タイトル     :string(100)    not null
# publish_date   公開日       :date           
# content        内容         :text           not null
# is_delete      削除         :boolean        
# is_confirmed   確認         :boolean        
# user_id        ユーザーID   :integer        
#
class Article < ApplicationRecord
  # アソシエーション
  belongs_to :user, optional: true

  # バリデーション
  validates :title, presence: true, length: { maximum: 100 }
#  validates :publish_date, date: true, allow_nil: true, allow_blank: true
  validates :content, presence: true, length: { maximum: 65535 } 

  # TODO:検索ソートに組み入れない項目は下記の配列から除外すること
  def self.ransackable_attributes (auth_object = nil)
    %w(title publish_date content is_delete is_confirmed user_id)
  end
end
