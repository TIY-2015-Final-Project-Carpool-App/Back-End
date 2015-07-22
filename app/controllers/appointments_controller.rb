class AppointmentsController < ApplicationController
  before_action :authenticate_with_token!

  def index_carpool
    @carpool = Carpool.find(params[:id])
    @appointments = @carpool.appointments
    unless @appointments.empty?
      render 'index.json.jbuilder', locals: { appointments: @appointments }, status: :ok
    else
      render json: { errors: "No appointments found on specifed carpool ID." }, status: :bad_request
    end
  end

  def index_user
    @user = User.find_by!(username: params[:username])
    @riders = @user.riders
    unless @riders.empty?
      render 'riders/rider_index.json.jbuilder', locals: { riders: @riders }, status: :ok
    else
      render json: { errors: "No appointments found for specified user." }, status: :bad_request
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    render partial: 'appointment2.json.jbuilder', locals: { appointment: @appointment }, status: :ok
  end

  # Need to add restrictions to creation of appointments to users verified in the group only
  def create
    attributes = set_attributes(params)
    @carpool = Carpool.find(params[:id])
    @appointment = current_user.created_appointments.new(attributes)
    @appointment.carpool_id = @carpool.id
    if @appointment.save
      @rider = current_user.riders.create(appointment_id: @appointment.id, rider_role: "Driver")
      render partial: 'appointment2.json.jbuilder', locals: { appointment: @appointment }, status: :created
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attributes = set_attributes(params)
    @appointment = current_user.created_appointments.find(params[:id])
    if @appointment.update(attributes)
      render partial: 'appointment2.json.jbuilder', locals: { appointment: @appointment }, status: :ok
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    @appointment = current_user.created_appointments.find(params[:id])
    if @appointment.destroy
      render json: { message: "Appointment deleted." }, status: :no_content
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :start, :title, :description,
      :origin, :destination, :distance_filter,
      :seats
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end