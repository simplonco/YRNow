require 'sinatra'
require 'oauth2'

get '/' do 
	erb :auth
end

get '/presentation' do
	"Hackathon Simplon YRNOW"
end

get '/hi' do
	erb :home
end