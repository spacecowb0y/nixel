# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(:name =>'Maxi', :email => 'maxi@nixel.com.ar', :password => 'password', :password_confirmation => 'password')
AdminUser.create!(:name =>'Gise', :email => 'gise@nixel.com.ar', :password => 'password', :password_confirmation => 'password')
AdminUser.create!(:name =>'Marco', :email => 'marco@nixel.com.ar', :password => 'password', :password_confirmation => 'password')
AdminUser.create!(:name =>'Diego', :email => 'diego.peralta.dev@gmail.com', :password => 'password', :password_confirmation => 'password')
