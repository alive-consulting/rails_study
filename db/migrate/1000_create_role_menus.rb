class CreateRoleMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :role_menus, comment: 'ロール～メニューリンク' do |t|
      t.references :role, type: :bigint, foreign_key: true, comment: 'ロール'
      t.references :menu, type: :bigint, foreign_key: true, comment: 'メニュー'
      t.timestamps null:true
    end
  end
end
