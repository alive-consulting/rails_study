class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, comment: 'ロール' do |t|
      t.string :name, limit: 20, null: false, comment: '名前'
      t.text :explanation, comment: '説明'
      t.integer :create_id, comment: '作成者'
      t.integer :update_id, comment: '更新者'
      t.timestamps null:true
    end
  end
end
