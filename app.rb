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

get "/posts/new" do
  haml :posts_new
end

post "/posts" do
  @post = Post.new(params[:post])
  @post.save
  session[:notice] = "Your post was successfully created."
  redirect "/posts/#{@post.to_param}"
end

get %r{/posts/(\d+)} do |post_id|
  @post = Post.find(post_id)
  @notice = session[:notice]
  session[:notice] = nil
  haml :posts_show
end
