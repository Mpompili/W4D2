# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Cat.destroy_all
CatRentalRequest.destroy_all

cat1 = Cat.create(name: 'kath', birth_date: '2005/1/20', color: 'orange', sex: 'F', description: 'cool cat')
cat2 = Cat.create(name: 'becky', birth_date: '2000/1/20', color: 'black', sex: 'F', description: 'old cool cat')

rental1 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2018/5/10', end_date: '2018/5/15')
rental2 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2018/6/10', end_date: '2018/6/15')
