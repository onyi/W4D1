# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

5.times { User.create(username: Faker::Name.unique.name) }

5.times { Artwork.create(title: Faker::Name.unique.name, image_url: Faker::Internet.url , artist_id: User.all.sample.id) }


def artwork_shared_helper
  viewer_id = User.all.sample.id
  artwork = Artwork.all.sample
  viewer_id = User.all.sample.id until artwork.artist_id != viewer_id
  return [viewer_id, artwork.id] 
end
i = 1
until i == 5 do 
    res = artwork_shared_helper
    p res
    if ArtworkShare.create(viewer_id: res[0], artwork_id: res[1])
      i += 1
    end
end

