require 'rubygems'
require 'sinatra'
require 'haml'
require 'activerecord'

Dir["lib/**/*.rb"].each {|file| require(file) }

configure do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'development.sqlite3'
  )
end

use Rack::Session::Cookie

get "/" do
  haml :posts_index
end

get %r{/posts/(\d+)} do |post_id|
  @post = Post.find(post_id)
  haml :posts_show
end

get "/posts/new" do
  @post = Post.new
  haml :posts_new
end

post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    session[:notice] = "Your post was successfully created."
    redirect "/posts/#{@post.to_param}"
  else
    haml :posts_new
  end
end

get "/sessions/new" do
  haml :sessions_new
end

post "/sessions" do
  if user = User.authenticate(params[:email], params[:password])
    session[:notice] = "You have been successfully signed in."
    session[:user_id] = user.id
    redirect "/"
  else
    session[:notice] = "Invalid e-mail or password."
    haml :sessions_new
  end
end

get "/signout" do
  session[:notice] = "You have been successfully signed out."
  session[:user_id] = nil
  redirect '/'
end

helpers do
  def notice
    result = session[:notice]
    session[:notice] = nil
    result
  end

  def signed_in_user
    @signed_in_user ||= (session[:user_id] && User.find(session[:user_id]))
  end

  def signed_in?
    session[:user_id].present?
  end
end
