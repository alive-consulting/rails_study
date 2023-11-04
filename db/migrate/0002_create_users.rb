class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, comment: 'ユーザー' do |t|
      t.string :name, limit: 20, null: false, comment: '名前'
      t.integer :client_id, null: false, comment: '顧客ID'
      t.integer :role_id, null: false, comment: 'ロールID'
      t.boolean :is_deposit_prohibited, default: 0, comment: '入金禁止'
      t.string :locale, limit: 2, comment: 'ロケール'
      t.integer :create_id, comment: '作成者'
      t.integer :update_id, comment: '更新者'
      t.timestamps null:true
    end
    add_index :users, :client_id
    add_index :users, :role_id
  end
end
