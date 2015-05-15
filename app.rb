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
  @band = Band.create({:name => name, :genre => genre})

  @for_band = true
  if @band.save
    redirect to('/bands')
  else
    erb(:errors)
  end
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
  @venue = Venue.create(:name => name, :city => city)
  if @venue.save
    redirect to('/venues')
  else
    erb(:errors)
  end
end

get('/venues/:venue_id') do
  @venue = Venue.find(params.fetch('venue_id'))
  erb(:venue)
end

delete('/bands/:band_id') do
  @band = Band.find(params.fetch('band_id').to_i)
  @band.delete
  redirect to('/bands')
end
