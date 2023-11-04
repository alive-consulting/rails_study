class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles, comment: '記事' do |t|
      t.string :title, limit: 100, null: false, comment: 'タイトル'
      t.date :publish_date, comment: '公開日'
      t.text :content, null: false, comment: '内容'
      t.boolean :is_delete, comment: '削除'
      t.boolean :is_confirmed, comment: '確認'
      t.integer :user_id, comment: 'ユーザーID'
      t.integer :create_id, comment: '作成者'
      t.integer :update_id, comment: '更新者'
      t.timestamps
    end
    add_index :articles, :user_id
  end
end
