class ChildrenController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :show, :update, :delete, :create]

  def index
    @user = User.find_by(username: params[:username])
    @children = @user.children
    if @children
      render 'index.json.jbuilder', status: :ok
    else
      render json: { errors: @children.errors.full_messages }, status: :bad_request
    end
  end

  def create
    if params[:dob]
      if dob_format(params[:dob])
        create_child(params)
      else
        render json: { errors: "DOB format is incorrect." }, status: :unprocessable_entity
      end
    else 
      create_child(params)
    end
  end

  def show
    @child = Child.find_by(id: params[:id])
    if @child
      render partial: 'child2.json.jbuilder', locals: { child: @child }, status: :ok
    else
      render json: { errors: "Child with specified ID is not found." }, status: :bad_request
    end
  end

  def update
    if params[:dob]
      if dob_format(params[:dob])
        update_child(params)
      else
        render json: { errors: "DOB format is incorrect." }, status: :unprocessable_entity
      end
    else
      update_child(params)
    end
  end

  def delete
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    if current_user.access_token == @user.access_token
      if @child.destroy
        render json: { message: "Child Deleted." }, status: :no_content
      else
        render json: { errors: "Invalid Request." }, status: :bad_request 
      end
    else
      render json: { message: "Unauthorized to delete this child." }, status: :unauthorized
    end
  end

  private
  
  DOB_REGEX = /\A(3[01]|[12][0-9]|0?[1-9])\/(1[0-2]|0?[1-9])\/(?:[0-9]{2})?[0-9]{2}\z/
  
  def dob_format(dob)
    DOB_REGEX =~ dob
  end

  def set_attributes(params)
    attributes = { }
    list = [
      :first_name, :last_name, :age, :dob,
      :address, :phone_number, :height, :weight, 
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

  def create_child(params)
    attributes = set_attributes(params)
    if params[:username]
      @user = User.find_by(username: params[:username])
      @child = @user.children.new(attributes)
    else
      @child = current_user.children.new(attributes)
    end

    if @child.save
      render partial: 'child2.json.jbuilder', locals: { child: @child }, status: :created
    else
      render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_child(params)
    attributes = set_attributes(params)
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    if current_user.access_token == @user.access_token
      if @child.update(attributes)
        render partial: 'child2.json.jbuilder', locals: { child: @child }, status: :ok
      else
        render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized to modify this child." }, status: :unauthorized
    end
  end

end
