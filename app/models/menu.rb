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
class Menu < ApplicationRecord
  default_scope -> { order(display_order: :asc) }

  # アソシエーション
  # rolesとN:Nアソシーエーション
  has_many :role_menus, dependent: :destroy
  has_many :roles, through: :role_menus, dependent: :delete_all

  # バリデーション
  validates :logical_name, length: { maximum: 100 }
  validates :physical_name, length: { maximum: 100 }
  validates :url, length: { maximum: 100 }
  validates :display_order, allow_nil: true, allow_blank: true, numericality: { only_integer: true } 

  # TODO:検索ソートに組み入れない項目は下記の配列から除外すること
  def self.ransackable_attributes (auth_object = nil)
    %w(parent_id child_id logical_name physical_name url display_order is_show)
  end
end
