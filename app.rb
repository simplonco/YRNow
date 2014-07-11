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

# clés heroku
# KEY='306691358040-9h1dj47fsug5hlk9lrgua5f37siarmr1.apps.googleusercontent.com'
# SECRET='VWUZKcvduyjAlL6TbPWTXZ1Z'

soin = [{"REF"=>8, "Type"=> "SOIN", "Libellé_conseil"=> "Mon rituel hydratation", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/fmttJ7ya9V4' frameborder='0' allowfullscreen></iframe>", "Age_Debut"=> 20, "Age_Fin"=> 40, "Skin type"=> "dehydrated skin", "Weather"=> "all", "Produit 1"=> 71991, "Produit 2"=> 33247, "Produit 3"=> 18786, "Produit 4"=> 70086},{"REF"=>9, "Type"=> "SOIN", "Libellé_conseil"=> "Sérum + crème : le tandem belle peau", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/FOLe7KJ8bE4' frameborder='0' allowfullscreen></iframe>", "Age_Debut"=> 40, "Age_Fin"=> 70, "Skin type"=> "all", "Weather"=> "all", "Produit 1"=> 76668, "Produit 2"=> 73952, "Produit 3"=> 02103, "Produit 4"=> 74422},{"REF"=>10, "Type"=> "SOIN", "Libellé_conseil"=> "Préparer sa peau au soleil", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/OrjAd7vN-mE' frameborder='0' allowfullscreen></iframe>", "Age_Debut"=> 0, "Age_Fin"=> 80, "Skin type"=> "all", "Weather"=> "Good Weather", "Produit 1"=> 11865, "Produit 2"=> 14259, "Produit 3"=> 23797, "Produit 4"=> 26852},{"REF"=>11, "Type"=> "SOIN", "Libellé_conseil"=> "Peaux sèches et rides : tous les conseils", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/6xp-sDM3hzw' frameborder='0' allowfullscreen></iframe>", "Age_Debut"=> 40, "Age_Fin"=> 70, "Skin type"=> "dry skin", "Weather"=> "Bad Weather", "Produit 1"=> 20890, "Produit 2"=> 36325, "Produit 3"=> 38362, "Produit 4"=> 17114},{"REF"=>12, "Type"=> "SOIN", "Libellé_conseil"=> "Mes soins beauté express", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/kK0dIY-Uj1A' frameborder='0' allowfullscreen></iframe>", "Age_Debut"=> 0, "Age_Fin"=> 80, "Skin type"=> "dehydrated skin", "Weather"=> "Good Weather", "Produit 1"=> 27606, "Produit 2"=> 65293, "Produit 3"=> 86551, "Produit 4"=> 86551}]
makeup = [{"REF"=>1, "Type"=> "MAKE UP", "Libellé_conseil"=> "Mon maquillage collection de l'été", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/OJrg37YlFPU' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 20, "Age_Fin_conseil"=> 40, "Eyes color_conseil"=> "all", "Hair color_conseil"=> "all", "dayornight_conseil"=> "day", "Produit_1"=> 15485, "Produit_2"=> 18231, "Produit_3"=> 3086, "Produit_4"=> 18786},{"REF"=>2, "Type"=> "MAKE UP", "Libellé_conseil"=> "Les astuces maquillage pour les rousses", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/1dfP7Xh4N5U' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 0, "Age_Fin_conseil"=> 80, "Eyes color_conseil"=> "green", "Hair color_conseil"=> "ginger", "dayornight_conseil"=> "day", "Produit_1"=> 66855, "Produit_2"=> 70458, "Produit_3"=> 26465, "Produit_4"=> 69114},{"REF"=>3, "Type"=> "MAKE UP", "Libellé_conseil"=> "Les secrets de l'œil smoky", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/LnwQH_iMKj4' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 20, "Age_Fin_conseil"=> 50, "Eyes color_conseil"=> "brown", "Hair color_conseil"=> "all", "dayornight_conseil"=> "night", "Produit_1"=> 71259, "Produit_2"=> 54849, "Produit_3"=> 87489, "Produit_4"=> 71023},{"REF"=>4, "Type"=> "MAKE UP", "Libellé_conseil"=> "Astuces maquillage pour masquer les défauts", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/bAZ1pn3l4HI' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 40, "Age_Fin_conseil"=> 80, "Eyes color_conseil"=> "all", "Hair color_conseil"=> "all", "dayornight_conseil"=> "day", "Produit_1"=> 22971, "Produit_2"=> 69868, "Produit_3"=> 74263, "Produit_4"=> 69114},{"REF"=>5, "Type"=> "MAKE UP", "Libellé_conseil"=> "Les astuces maquillage pour les brunes aux yeux foncés", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/Gt9sLsLZdLE' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 20, "Age_Fin_conseil"=> 40, "Eyes color_conseil"=> "brown", "Hair color_conseil"=> "brun", "dayornight_conseil"=> "all", "Produit_1"=> 69114, "Produit_2"=> 71259, "Produit_3"=> 69868, "Produit_4"=> 87489},{"REF"=>6, "Type"=> "MAKE UP", "Libellé_conseil"=> "Les astuces maquillage pour les blondes aux yeux clairs", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/LYAovoZ1x4U' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 20, "Age_Fin_conseil"=> 40, "Eyes color_conseil"=> "blue", "Hair color_conseil"=> "blond", "dayornight_conseil"=> "all", "Produit_1"=> 69114, "Produit_2"=> 71259, "Produit_3"=> 87489, "Produit_4"=> 87489},{"REF"=>7, "Type"=> "MAKE UP", "Libellé_conseil"=> "Le look naturel sophistiqué", "Lien_Youtube"=> "<iframe width='560' height='315' src='//www.youtube.com/embed/piN3jNQH-zE' frameborder='0' allowfullscreen></iframe>", "Age_début_conseil"=> 0, "Age_Fin_conseil"=> 80, "Eyes color_conseil"=> "all", "Hair color_conseil"=> "blond", "dayornight_conseil"=> "all", "Produit_1"=> 74263, "Produit_2"=> 66855, "Produit_3"=> 69114, "Produit_4"=> 70458}]

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
  redirect url('/liste_conseils')
end

get '/main.css' do
  stylus :main
end

get '/liste_conseils' do
  haml :liste_conseils
end
