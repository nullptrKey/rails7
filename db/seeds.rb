# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

# puts "Seeding users..."
# 10.times do
#   # password = Faker::Internet.password(min_length: 8) # 生成随机密码
#   password = "12345678"
#   user = User.create(
#     username: Faker::Internet.username,
#     email: Faker::Internet.email,
#     password: password
#   )
#   if user.errors.any?
#     puts "Failed to create user: #{user.errors.full_messages.join(', ')}"
#   else
#     puts "Created user: #{user.username} (#{user.email})"
#   end
# end
puts "Seeding Articles..."
# 获取所有用户的 ID
user_ids = User.pluck(:id)

# 创建 20 篇文章
20.times do
  Article.create!(
    title: Faker::Lorem.sentence(word_count: 3),  # 生成一个包含 3 个单词的句子作为标题
    text: Faker::Lorem.paragraph(sentence_count: 5),  # 生成一个包含 5 个句子的段落作为正文
    user_id: user_ids.sample  # 从用户 ID 列表中随机选择一个
  )
end
