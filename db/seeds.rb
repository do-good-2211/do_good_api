# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

picard = User.create(name: 'Jean-Luc Picard', email: 'captain@gmail.com', uid: '55055', provider: 'Google Baby!')
riker = User.create(name: 'William Riker', email: 'number2@gmail.com', uid: '22022', provider: 'Google Baby!')
data = User.create(name: 'Data', email: 'data@gmail.com', uid: '33033', provider: 'Google Baby!')
geordi = User.create(name: 'Geordi La Forge', email: 'chief-engineer@gmail.com', uid: '44044', provider: 'Google Baby!')

deed1 = GoodDeed.create(status: 1, name: 'Help Others.', host_id: "#{picard.id}", date: '01-01-2023', time: '16:00', notes: 'Worth it!', media_link: 'https://images.unsplash.com/photo-1679227679356-7a3d5bd5d8be?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MzM0NTl8MHwxfHJhbmRvbXx8fHx8fHx8fDE2ODA5NzUzMDE&ixlib=rb-4.0.3&q=80&w=400')
deed2 = GoodDeed.create(status: 1, name: 'Help Others2.', host_id: "#{picard.id}", date: '01-01-2023', time: '16:00', notes: 'Worth it!', media_link: 'https://images.unsplash.com/photo-1679227679356-7a3d5bd5d8be?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MzM0NTl8MHwxfHJhbmRvbXx8fHx8fHx8fDE2ODA5NzUzMDE&ixlib=rb-4.0.3&q=80&w=400')
deed3 = GoodDeed.create(status: 1, name: 'Help Others3.', host_id: "#{picard.id}", date: '01-01-2023', time: '16:00', notes: 'Worth it!', media_link: 'https://images.unsplash.com/photo-1679227679356-7a3d5bd5d8be?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MzM0NTl8MHwxfHJhbmRvbXx8fHx8fHx8fDE2ODA5NzUzMDE&ixlib=rb-4.0.3&q=80&w=400')
deed4 = GoodDeed.create(status: 1, name: 'Help Others4.', host_id: "#{riker.id}", date: '01-01-2023', time: '16:00', notes: 'Worth it!', media_link: 'https://images.unsplash.com/photo-1679227679356-7a3d5bd5d8be?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MzM0NTl8MHwxfHJhbmRvbXx8fHx8fHx8fDE2ODA5NzUzMDE&ixlib=rb-4.0.3&q=80&w=400')
deed5 = GoodDeed.create(name: 'Help Others5.', host_id: "#{data.id}", date: '01-01-2023', time: '16:00')

UserGoodDeed.create(user_id: "#{picard.id}", good_deed_id: "#{deed1.id}")
UserGoodDeed.create(user_id: "#{riker.id}", good_deed_id: "#{deed1.id}")

UserGoodDeed.create(user_id: "#{picard.id}", good_deed_id: "#{deed2.id}")
UserGoodDeed.create(user_id: "#{riker.id}", good_deed_id: "#{deed2.id}")
UserGoodDeed.create(user_id: "#{geordi.id}", good_deed_id: "#{deed2.id}")

UserGoodDeed.create(user_id: "#{picard.id}", good_deed_id: "#{deed3.id}")

UserGoodDeed.create(user_id: "#{riker.id}", good_deed_id: "#{deed4.id}")
UserGoodDeed.create(user_id: "#{picard.id}", good_deed_id: "#{deed4.id}")
UserGoodDeed.create(user_id: "#{data.id}", good_deed_id: "#{deed4.id}")
UserGoodDeed.create(user_id: "#{geordi.id}", good_deed_id: "#{deed4.id}")

UserGoodDeed.create(user_id: "#{data.id}", good_deed_id: "#{deed5.id}")
