# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@admin = Admin.create(email: "alfredo@rockstars.mx", password: "123456789")
@admin2 = Admin.create(email: "carolina.cortes@research-ss.com", password: "carolina123")

@admina = Admin.create(email: "arodriguez@research-ss.com", password: "antonio73")
@adminb = Admin.create(email: "elba.mejia@research-ss.com", password: "elba8444")
@adminc = Admin.create(email: "sergio.cordova@research-ss.com", password: "sergio984")
@admind = Admin.create(email: "manuel.diaz@research-ss.com", password: "manuel543")