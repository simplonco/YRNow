require 'pry'
require 'sinatra'
require 'oauth'
require 'omniauth'
require 'omniauth-google-oauth2'
require 'haml'
require 'stylus'
require 'stylus/tilt'

enable :sessions

configure do
  use Rack::Session::Cookie, :secret => Digest::SHA1.hexdigest(rand.to_s)
  KEY='306691358040-tj1tltsv8ttd3gtmd5e11l42bej1fn2t.apps.googleusercontent.com'
  SECRET='fm2nmcEkUEMeLYllE1pE6NKn'
end

use OmniAuth::Builder do
  provider :google_oauth2, KEY, SECRET
end

def access_token
  consumer = OAuth::Consumer.new(KEY, SECRET)
  OAuth::AccessToken.from_hash(consumer, session[:oauth_credentials])
end

get '/' do 
  haml :auth
end

get '/auth/google_oauth2/callback' do
  halt(401, 'Non Autorisé') unless env['omniauth.auth']
  session[:oauth_credentials] = env['omniauth.auth']['credentials']
  session[:oauth_info] = env['omniauth.auth']['info']
  binding.pry
  session[:user_name]= env['omniauth.auth'].info.first_name
  session[:user_lname]= env['omniauth.auth'].info.last_name
  session[:user_image]= env['omniauth.auth'].info.image
  session[:authenticated] = true
  redirect url('/home')

end

get '/presentation' do
  "Hackathon Simplon YRNOW"
end

get '/home' do
  haml :home
end

get '/advice' do
  haml :advice
end

get '/main.css' do
  stylus :main
end
