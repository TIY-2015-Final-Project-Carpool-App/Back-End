class PostsController < ApplicationController

  def index
    @carpool = Carpool.find(params[:id])
    @posts = @carpool.posts
    if @posts
      render 'index.json.jbuilder', locals: { posts: @posts }, status: :ok
    else
      render json: { errors: 'No posts found for specified Carpool.' }, status: :not_found
    end
  end

  def show
    @post = Post.find(params[:id])
    render partial: 'post.json.jbuilder', locals: { post: @post }, status: :ok
  end

  def create
    @carpool = Carpool.find(params[:id])
    attributes = set_attributes(params)
    @post = current_user.posts.new(attributes)
    @carpool.posts << @post
    if @post.save
      render partial: 'post.json.jbuilder', locals: { post: @post }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    attributes = set_attributes(params)
    if @post.update(attributes)
      render partial: 'post.json.jbuilder', locals: { post: @post }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      render json: { message: "Post deleted." }, status: :no_content
    else
      render json: { errors: "Unable to delete post." }, status: :unprocessable_entity
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :urgency, :title, :body
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end
