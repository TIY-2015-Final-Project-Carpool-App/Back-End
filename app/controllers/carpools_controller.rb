class CarpoolsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    if params[:username]
      @user = User.find_by(username: params[:username])
      @carpools = Carpool.joins(:joined_carpools).where(joined_carpools: { user_id: @user } )
      if @carpools
        render 'index.json.jbuilder', status: :ok
      else
        render json: { errors: 'No carpools found.' }, status: :bad_request
      end
    else
      @carpools = Carpool.page(params[:page]).per(params[:per])
      if @carpools
        render 'index.json.jbuilder', status: :ok
      else
        render json: { errors: 'No carpools found.' }, status: :bad_request
      end
    end  
  end

  def invites
    @user = User.find_by(username: params[:username])
    if @user
      @joined_carpools = @user.joined_carpools.where(activated: false)
      if @joined_carpools 
        render 'invites.json.jbuilder', status: :ok
      else  
        render json: { errors: "No unaccepted carpool invitations for this user." }, status: :bad_request
      end
    else
      render json: { message: "No invites found." }, status: :bad_request
    end
  end

  def show
    @carpool = Carpool.find_by(id: params[:id])
    if @carpool
      render partial: 'carpool', locals: { carpool: @carpool }, status: :ok
    else
      render json: { message: "No carpool found with specified ID." }, status: :bad_request
    end
  end

  def create
    attributes = set_attributes(params)
    @carpool = current_user.created_carpools.new(attributes)
    if @carpool.save
      @joined_carpool = current_user.joined_carpools.create(carpool_id: @carpool.id, activated: true)
      render partial: 'carpool', locals: { carpool: @carpool }, status: :created
    else
      render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Require username if user joining != current_user
  def join
    emails = params[:emails]
    @carpool = current_user.created_carpools.find(params[:id])
    @carpool = @carpool.join_emails(emails)
    @joined_carpools = @carpool.joined_carpools

    render 'joins.json.jbuilder', locals: { joined_carpools: @joined_carpools }, status: :created
  end

  def update
    @carpool = Carpool.find_by(id: params[:id])
    if @carpool
      attributes = set_attributes(params)
      if @carpool.update(attributes)
        render partial: 'carpool', locals: { carpool: @carpool }, status: :ok
      else
        render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "No carpool found with specified ID." }, status: :bad_request
    end
  end

  def activate
    @carpool = Carpool.find_by(id: params[:id])
    if @carpool
      @joined_carpool = @carpool.joined_carpools.where(user_id: current_user.id).first
      if @joined_carpool && @joined_carpool.activated == false
        if params[:join_token] == @joined_carpool.join_token
          @joined_carpool.update(activated: true)
          render partial: 'joined', locals: { joined_carpool: @joined_carpool }, status: :ok
        else  
          render json: { errors: 'Incorrect join_token.' }, status: :bad_request
        end
      else
        render json: { errors: 'Current logged in user has not joined this carpool, or user is already activated.' },
                      status: :bad_request
      end
    else
      render json: { errors: 'No carpool found with specified ID.' }, status: :bad_request
    end
  end

  def delete
    @carpool = Carpool.find_by(id: params[:id])
    if current_user.access_token == @carpool.creator.access_token
      if @carpool.destroy
        render json: { message: "Carpool group deleted." }, status: :no_content
      else
        render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Current user is not authorized to delete this carpool." }, 
                     status: :unauthorized
    end
  end

  def remove
    @user = User.find_by(username: params[:username])
    @carpool = Carpool.find_by(id: params[:id])
    @joined_carpool = @carpool.joined_carpools.where(user_id: @user.id).first
    if current_user.access_token == @user.access_token || current_user.access_token == @carpool.creator.access_token
      if @joined_carpool.destroy
        render partial: 'carpool', locals: { carpool: @carpool }, status: :ok
      else
        render json: { errors: @joined_carpool.errors.full_messages }, status: :bad_request
      end
    else
      render json: { message: 'Current user is not authorized to remove this user from specified carpool.' },
                     status: :unauthorized
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :title, :description
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end



