class CreateCheckReceives < ActiveRecord::Migration[6.0]
  def change
    create_table :check_receives, comment: 'サンプル受信API' do |t|
      t.string :amount, limit: 15, comment: '取引金額'
      t.string :seq_no, limit: 6, comment: '取引通番'
      t.string :settlement_day, limit: 8, comment: '勘定日付'
      t.string :tran_time, limit: 14, comment: 'トランザクション日時'
      t.string :atm_id, limit: 6, comment: 'ATM番号'
      t.string :sec_inf, limit: 255, comment: '詳細情報'
      t.integer :status, default: 0, comment: 'ステータス'
      t.integer :create_id, comment: '作成者'
      t.integer :update_id, comment: '更新者'
      t.timestamps null:true
    end
  end
end
