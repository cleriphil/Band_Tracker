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
  venue_id = params.fetch('venue').to_i
  @venue = Venue.find(venue_id)
  if @band.venues.include?(@venue).!
    @band.venues.push([@venue])
  end
  redirect to("/bands/#{@band.id}")
end

patch('/bands/:band_id') do
  @band = Band.find(params.fetch('band_id').to_i)
  name = params.fetch('name')
  genre = params.fetch('genre')
  @band.update({:name => name})
  @band.update({:genre => genre})
  redirect to("/bands/#{@band.id}")
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
