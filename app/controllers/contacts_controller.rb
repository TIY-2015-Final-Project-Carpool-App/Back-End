class ContactsController < ApplicationController

  def index
    if params[:id]
      @child = Child.find_by(id: params[:id])
      @contacts = @child.contacts
    else
      @user = User.find_by(username: params[:username])
      @contacts = @user.contacts
    end

    if @contacts
      render json: @contacts.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { message: "No contacts found." }, status: :no_content
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
      render json: { errors: @contact.errors.full_message }, status: :unprocessable_entity
    end
  end

  def update
    attributes = set_attributes(params)
    @contact = Contact.find_by(id: params[:id])


  end

  def delete
    
  end

  private

  def set_attributes(params)
    attributes = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      relationship: params[:relationship],
      address: params[:address],
      phone_number: params[:phone_number],
      alternate_number: params[:alternate_number]
    }
  end

end
