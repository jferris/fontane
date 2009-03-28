require 'rubygems'
require 'sinatra'
require 'haml'
require 'activerecord'

configure do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'development'
  )
  Dir["lib/**/*.rb"].each {|file| require(file) }
end

get "/posts/new" do
  haml :posts_new
end

post "/posts" do
  @post = Post.new(params[:post])
  @post.save
  redirect "/posts/#{@post.to_param}"
end

get %r{/posts/(\d+)} do |post_id|
  @post = Post.find(post_id)
  session[:notice] = nil
  haml :posts_show
end
