require 'gossip'

class ApplicationController < Sinatra::Base
  
  # j'affiche new_gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  # je récupère les paramètres nom et potin et je lance la méthode sauvegarder
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # j'affiche la totalité des goosips dans l'index
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # j'affiche le nom et le potin demandé par l'index dans show 
  # je lance la classe Gossip et la méthode find
  get '/gossips/:id' do 
    erb :show, locals: {gossip: Gossip.find(params['id'].to_i)}
  end

  # j'affiche le nom et potin demandé dans édit
  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.find(params['id'].to_i)}
  end

  # je récupère les informations modifiés 
  post '/gossips/:id/edit' do
    Gossip.update(params['id'], params['gossip_author_new'], params['gossip_content_new']) 
    redirect '/'
  end
end