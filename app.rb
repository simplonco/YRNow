require 'pry'
require 'sinatra'
require 'oauth'
require 'omniauth'
require 'omniauth-google-oauth2'

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
	erb :auth
end

get '/auth/google_oauth2/callback' do
  halt(401, 'Non Autorisé') unless env['omniauth.auth']
  session[:oauth_credentials] = env['omniauth.auth']['credentials']
  session[:oauth_info] = env['omniauth.auth']['info']
  session[:user_name]= env['omniauth.auth'].info.first_name
  session[:authenticated] = true
  redirect url('/home')
end

get '/presentation' do
	"Hackathon Simplon YRNOW"
end

get '/home' do
	erb :home
end