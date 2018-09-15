# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [{email: 'Vasya@kremlin.ru', password: 'xxx'}, {email: 'Alex@mail.ru', password: 'aaa'}, {email: 'Frank@gmail.com', password: '111'}]
users.each do |user|
  account = User.new(email: user[:email])
  account.password = user[:password]
  account.password_digest
  account.save!
end

def make_category(seed_category)
  category = Category.create!(title: seed_category[:title])
  seed_category[:test].each do |(title, level)|
    test = Test.create!(title: title, level: level, category_id: category.id, user_id: 1)
    3.times do
      question = Question.create!(body: "Question about #{test.title}", test_id: test.id)
      Answer.create!(body: "Correct answer about #{test.title}", correct: true, question_id: question.id)
      Answer.create!(body: "Incorrect answer about #{test.title}", question_id: question.id)
    end
  end
end

make_category({title: 'Programming', test: [['Ruby', 2], ['Python', 1], ['c', 2]]})
make_category({title: 'Math', test: [['Geometry', 1], ['Trigonometry', 2]]})
make_category({title: 'Space', test: [['Moon', 0], ['Sun', 1], ['Venus', 1]]})