# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{username: 'Vasya'}, {username: 'Alex'}, {username: 'Frank'}]) 

category = Category.create!(title: 'Programming')
test = Test.create(title:'Ruby', level: 1, category_id: category.id)
question = Question.create(body: 'about Ruby,correct A', test_id: test.id)
Answer.create([{body: 'A. correct for Ruby question', correct: true, question_id: question.id},
              {body: 'B. incorrect for Ruby question', question_id:question.id}])

test = Test.create(title:'Python', level: 2, category_id: category.id)
question = Question.create(body: 'about Python,correct A', test_id: test.id)
Answer.create([{body: 'A. correct for Python question', correct: true, question_id: question.id},
              {body: 'B. incorrect for Python question', question_id:question.id}])

category = Category.create!(title: 'Math')
test = Test.create(title:'Geometry', level: 2, category_id: category.id)
question = Question.create(body: 'about Geometry,correct A', test_id: test.id)
Answer.create([{body: 'A. correct for Geometry question', correct: true, question_id: question.id},
              {body: 'B. incorrect for Geometry question', question_id:question.id}])

category = Category.create!(title: 'Space')
test = Test.create(title:'Moon', category_id: category.id)
question = Question.create(body: 'about Moon,correct A', test_id: test.id)
Answer.create([{body: 'A. correct for Moon question', correct: true, question_id: question.id},
              {body: 'B. incorrect for Moon question', question_id:question.id}])
