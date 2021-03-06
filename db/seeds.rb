# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 清空之前的词库
Vocabulary.delete_all
# 读取单词表文件
words = IO.readlines("./config/ext/wordlist.txt")
# 形成SQL语句需要的规范形式
words.map!{|w| ("('#{w.chomp}', '2016-04-27 20:00:00', '2016-04-28 20:00:00' , #{w.chomp.length} )") }
# 构造SQL语句用于执行
sql = "INSERT INTO vocabularies (word, created_at, updated_at, length) VALUES #{words.join(", ")}"
# 执行SQL语句
ActiveRecord::Base.connection.execute sql
