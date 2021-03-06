require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( 'models/artists.rb' )
require_relative( 'models/artworks.rb' )

also_reload( 'models/*' )

# set up route to home page
get '/index' do
  @artworks = Artwork.show_all
  @artists = Artist.show_all
  erb ( :artworks )
end

# set up route to admin page for managers
get '/admin' do
  @artworks = Artwork.show_all
  @artists = Artist.show_all
  erb ( :admin )
end

# set up route to add new artists form
get '/artist/add' do
  erb(:new_artist_form)
end

# set up route to add new artists to database
post '/artist/add' do
  @new_artist = Artist.new(params)
  @new_artist.save
  redirect '/admin'
end

# set up route to delete artists form database
post '/artist/:id/delete' do
  artist_id = params[:id]
  # Artwork.delete_by_artist(artist_id)
  Artist.delete(artist_id)
  redirect '/admin'
end

# set up route to add new artwork form
get '/artwork/add' do
  @artists = Artist.show_all
  erb(:new_artwork_form)
end

# set up route to add new artwork to database
post '/artwork/add' do
  @new_artwork = Artwork.new(params)
  @new_artwork.save
  redirect '/admin'
end

# set up route to delete artwork form database
post '/artwork/:id/delete' do
  artwork_id = params[:id]
  Artwork.delete(artwork_id)
  redirect '/admin'
end

get '/artwork/:id/edit' do
  artwork_id = params[:id]
  @artwork = Artwork.find(artwork_id)
  @artists = Artist.show_all
  erb(:edit_artwork_form)
end

post '/artwork/:id/update' do
  Artwork.new(params).update
  redirect '/admin'
end
