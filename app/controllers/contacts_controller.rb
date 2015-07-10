class ContactsController < ApplicationController
  before_action :authenticate_with_user!, except: [:create]

  def index
    if params[:id]
      @child = Child.find_by(id: params[:id])
      if @child 
        @contacts = @child.contacts
        if !@contacts.empty?
          render json: @contacts.as_json(except: [:created_at, :updated_at]), status: :ok
        else
          render json: { message: "No contacts found." }, status: :no_content
        end
      else
        render json: { errors: "Child not found." }, status: :bad_request
      end
    else
      @user = User.find_by(username: params[:username])
      if @user 
        @contacts = @user.contacts
        if !@contacts.empty?
          render json: @contacts.as_json(except: [:created_at, :updated_at]), status: :ok
        else
          render json: { message: "No contacts found." }, status: :no_content
        end
      else
        render json: { errors: "User not found." }, status: :bad_request
      end
    end
  end

  def create
    attributes = set_attributes(params)
    if params[:id]
      @child = Child.find_by(id: params[:id])
      @contact = @child.contacts.new(attributes)
    else
      @contact = current_user.contacts.new(attributes)
    end
    if @contact.save
      render json: @contact.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attributes = set_attributes(params)
    @contact = Contact.find_by(id: params[:id])
    if @contact.contactable_type == "Child"
      @child = Child.find_by(id: @contact.contactable_id)
      if current_user.access_token == @child.user.access_token
        update_contact(attributes, @contact)
      else
        render json: { message: "Unauthorized to delete this contact." }, status: :unauthorized
      end
    else
      @user = User.find_by(id: @contact.contactable_id)
      if current_user.access_token == @user.access_token
        update_contact(attributes, @contact)
      else
        render json: { message: "Unauthorized to delete this contact." }, status: :unauthorized
      end
    end
  end

  def delete
    @contact = Contact.find_by(id: params[:id])
    if @contact.contactable_type == "Child"
      @child = Child.find_by(id: @contact.contactable_id)
      if current_user.access_token == @child.user.access_token
        destroy_contact(@contact)
      else
        render json: { message: "Unauthorized to delete this contact." }, status: :unauthorized
      end
    else
      @user = User.find_by(id: @contact.contactable_id)
      if current_user.access_token == @user.access_token
        destroy_contact(@contact)
      else
        render json: { message: "Unauthorized to delete this contact." }, status: :unauthorized
      end
    end
  end

  private

  def update_contact(attributes, contact)
    if contact.update(attributes)
      render json: contact.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy_contact(contact)
    if contact.destroy
      render json: { message: "Contact deleted." }, status: :no_content
    else
      render json: { errors: contact.errors.full_messages }, status: :bad_request
    end
  end

  def set_attributes(params)
    attributes = { }
    list = [
      :first_name, :last_name, :relationship,
      :address, :phone_number, :alternate_number
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end
end
