require 'sinatra/base'
# require 'sinatra'
require 'sinatra/activerecord'

# モジュラー構造を設定　設定はその直下に置く
class MyApp < Sinatra::Base

  set :database, {
    adapter:  "mysql2",
    host:     "localhost",
    username: "root",          # Windowsの標準ユーザー名
    password: "mysql2023", # 【重要】MySQLインストール時に決めたパスワードを入力
    database: "sinatratest"
  }

class User < ActiveRecord::Base; end

get '/users' do
  @users = User.all
  erb :users
end

get '/' do
  erb :index
end

get '/hello/:name' do
  "こんにちは、 #{params[:name]}さん！"
end

get '/form' do
  erb :form
end

post '/submit' do
  "あなたの名前は#{params[:name]}ですね！"
end

enable :sessions

post '/login' do
  session[:user] = params[:user]
  "ログインしました:#{session[:user]}"
end

get '/logout' do
  session.clear
  "ログアウトしました"
end

require 'json'

get '/api/greet/:name' do
  content_type :json
  { message: "こんにちは、#{params[:name]}さん!"}.to_json
end

posts = []

get '/posts' do
  erb :posts, locals: {posts: posts}
end

post '/posts' do
  posts << {title: params[:title], body: params[:body]}
  redirect '/posts'
end

run! if app_file == $0

end


