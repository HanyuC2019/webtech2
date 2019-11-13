# pgライブラリを使用する
require 'pg'

# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
<!-- ①ボタンを押すと、譲渡先が自家消費ではない物のgoyaの情報を載せたページが表示される機能を実装すること -->
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("select * from crops where not (give_for = '自家消費');")

  # 取り出した各行を処理する
  result.each do |record|
      # 各行を取り出し、putsでターミナル上に出力する
      puts "#{record["length"]}、#{record["weight"]}、#{record["quality"]}、#{record["give_for"]}、#{record["date"]}"
  end

begin
<!-- ②ボタンを押すと、品質が悪い物のgoyaの情報を載せたページが表示される機能を実装すること -->
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("select * from crops where quality = false;")

  # 取り出した各行を処理する
  result.each do |record|
      # 各行を取り出し、putsでターミナル上に出力する
      puts "#{record["length"]}、#{record["weight"]}、#{record["quality"]}、#{record["give_for"]}、#{record["date"]}}"
  end
ensure
  # 何かしらのエラーが発生した場合、
  # .finishでデータベースへのコネクションを切断する
  connection.finish
end