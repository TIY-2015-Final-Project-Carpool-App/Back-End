class MedicalsController < ApplicationController
  before_action :authenticate_with_token!, except: [:create]

  def show
    @child = Child.find_by(id: params[:id])
    @medical = @child.medical
    if @medical
      render partial: 'medical', status: :ok
    else
      render json: { message: "No medical information found." }, status: :no_content
    end
  end

  def create
    attributes = set_attributes(params)
    @child = Child.find_by(id: params[:id])
    @medical = Medical.new(attributes)
    @medical.child_id = @child.id
    if @medical.save
      render partial: 'medical', status: :created
    else
      render json: { errors: @medical.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attributes = set_attributes(params)
    @child = Child.find_by(id: params[:id])
    if current_user.access_token == @child.user.access_token
      @medical = @child.medical
      @medical.update(attributes)
      render partial: 'medical', status: :ok
    else
      render json: { message: "Unauthorized to modify this medical information." }, status: :unauthorized
    end
  end

  def delete
    @child = Child.find_by(id: params[:id])
    @medical = @child.medical
    if current_user.access_token == @child.user.access_token
      @medical.destroy
      render json: { message: "Medical Information deleted." }, status: :no_content
    else
      render json: { message: "Unauthorized to delete this medical information." }, status: :unauthorized
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :conditions, :medications, :notes, :allergies,
      :insurance, :religious_preference, :blood_type
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end
