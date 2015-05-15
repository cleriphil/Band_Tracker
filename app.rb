require('bundler/setup')
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
  erb(:index)
end

get('/bands') do
  @bands = Band.all
  erb(:bands)
end

get('/bands/new') do
  @venues = Venue.all
  erb(:band_form)
end

post('/bands') do
  name = params.fetch('name')
  genre = params.fetch('genre')
  band1 = Band.create({:name => name, :genre => genre})
  redirect to('/bands')
end

get('/bands/:band_id') do
  @band = Band.find(params.fetch('band_id').to_i)
  @venues = Venue.all
  erb(:band)
end

post('/bands/:band_id') do
  @band = Band.find(params.fetch('band_id').to_i)

  venue_ids = params[:venues]
  venues = []
  venue_ids.each() do |venue_id|
    new_venue = Venue.find(venue_id)
    venues.push(new_venue)
  end


  @band.venues.push(venues)

end

get('/venues') do
  @venues = Venue.all
  erb(:venues)
end

get('/venues/new') do
  erb(:venue_form)
end

post('/venues') do
  name = params.fetch('name')
  city = params.fetch('city')
  Venue.create(:name => name, :city => city)
  redirect to('/venues')
end
