require 'csv'
#
# csv取込
#  /db/seedsフォルダ配下のcsvファイルをテーブルに取り込みます
#  テーブル名とcsvファイル名は一致している必要あり。
#  usage:
#    rails db:seed                  ←/db/seeds配下全csv
#    rails db:seed reconciles.csv   ←/db/seeds/reconciles.csvファイル指定
def import_csv(path, target)
  table_name = ''
  begin
    # csvファイルを取り込んでインポート
    Dir.glob(File.join(Rails.root, path, target)) do |file|
      table_name = File.basename(file, ".csv")  # csvファイル名からテーブル名取得
      unless ActiveRecord::Base.connection.table_exists?(table_name)
        puts "#{table_name} \e[33mテーブルは存在しまｾﾝﾈ\e[0m"
        next
      end
      model = table_name.classify.constantize   # csvファイル名のテーブル名からモデルを取得
      model.destroy_all  # 追加する前にレコードを削除
      # DBにcsvの中身をインポート
      CSV.read(file, headers: true, encoding: 'CP932:UTF-8').each do |row|
        model.create!(row.to_hash)
      end
      # 処理レコード件数
      puts "#{table_name}を#{model.count}件登録しました。"
    end  
  rescue => e
    puts "#{table_name}にてエラー発生！#{e.backtrace.join("\n")}"
    exit
  end
end

#---------------------------------
# 本処理
#---------------------------------

# 指定csvファイル取込
target = ARGV[0]
# 引数が無ければ全seed実行
if target.nil?
  target = '*.csv'
  # active_storage用のディレクトリをクリア
  FileUtils.rm_rf(Dir.glob(Rails.root.join("storage/*")))
# 引数(ファイル指定)がある場合
else
  #seedsの中に存在しないファイルを指定した場合
  unless File.exist?(File.join(Rails.root,'db/seeds', target))
    pp "#{target} は存在しません"
    exit
  end
end

# csv取込その１
import_csv('db/seeds', target)
# 指定csvの場合、exit
exit unless ARGV[0].nil?

# csv取込その２
import_csv('db/seeds/nn', target)
