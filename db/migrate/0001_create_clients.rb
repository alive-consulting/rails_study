class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients, comment: '顧客' do |t|
      t.string :name, limit: 20, null: false, comment: '顧客名'
      t.integer :create_id, null: true, comment: '作成者'
      t.integer :update_id, null: true, comment: '更新者'
      t.timestamps null:true
    end
  end
end
