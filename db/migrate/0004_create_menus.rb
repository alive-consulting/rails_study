class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus, comment: 'メニュー' do |t|
      t.integer :parent_id, comment: '親ID'
      t.integer :child_id, comment: '子ID'
      t.string :logical_name, limit: 100, comment: '論理名'
      t.string :physical_name, limit: 100, comment: '物理名'
      t.string :url, limit: 100, comment: 'URL'
      t.integer :display_order, comment: '表示順'
      t.boolean :is_show, null: false, default: 1, comment: 'メニュー表示'
      t.integer :create_id, comment: '作成者'
      t.integer :update_id, comment: '更新者'
      t.timestamps null:true
    end
  end
end
