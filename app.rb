require 'sinatra'

get '/' do
	"Hackathon Simplon YRNOW"
end

get '/hi' do
	erb :home
end