# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
    User.where(:uid => 'lighthawky@gmail.com', :email => 'lighthawky@gmail.com', :name => 'Yonatan Bergman', :nickname => 'yonbergman', :image => 'https://secure.gravatar.com/avatar/a9d448bfe50a5452f6f17362b1febc07?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png').first_or_create,
    User.where(:uid => 'shay.h.davidson@gmail.com', :email => 'shay.h.davidson@gmail.com', :name => 'Shay Davidson', :nickname => 'shaydavidson', :image => 'https://secure.gravatar.com/avatar/93bfc73f376fc86692cdf8bd084c29b7?s=60&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png').first_or_create
]

org = Organization.where(:name => 'iic-ninjas', :github_id => '5079491').first_or_create
Project.where(:title => 'Katalog',
              :subtitle => 'A place where you can write and talk about ideas and side-projects',
              :repo_url => 'https://github.com/TheGiftsProject/katalog'
              ).first_or_create(
              :status => :lifted,
              :users => users,
              :organization => org
            )
