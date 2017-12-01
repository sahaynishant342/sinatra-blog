# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class Post < ActiveRecord::Base
end

# render homepage
get "/" do
  @posts = Post.order("created_at DESC")
  erb :"posts/index"
end

# render post creation page
get "/posts/create" do
  erb :"posts/create"
end

# save post
post "/posts/" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    # TODO : show error message
    redirect "/"
  end
end

# render edit page
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  erb :"posts/edit"
end

# edit post
post "/posts/:id" do
  @post = Post.find params[:id]
  @post.update params[:post]
  redirect "/"
end

# render post view page
get "/posts/:id" do
  @post = Post.find(params[:id])
  erb :"posts/view"
end

