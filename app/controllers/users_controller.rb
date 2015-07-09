class UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update, :delete, :show]

	def index
		@users = User.page(params[:page]).per(params[:per])
		render 'index.json.jbuilder', status: :ok
	end

	def create
		pass_hash = password_hash(params[:password])
		attributes = {
			username: params[:username],
			password: pass_hash,
			first_name: params[:first_name],
			last_name: params[:last_name],
			address: params[:address],
			phone_number: params[:phone_number],
			email: params[:email],
			avatar: params[:avatar]
		}
		@user = User.new(attributes)
		if @user.save
			render json: { user: @user.as_json(only: [:id, :username, :first_name, 
										:last_name, :address, :phone_number, :email, :avatar, :access_token]) }, 
                    status: :created
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def login
		@user = User.find_by(username: params[:username])
		pass_hash = Digest::SHA1.hexdigest(params[:password])
 		if @user && pass_hash == @user.password
      render json: { user: @user.as_json(only: [:id, :username, :email, :access_token]) },
        status: :created
    else
      render json: { message: "Invalid login or password." },
        status: :unauthorized
    end
	end

	def update
		@user = User.find_by(username: params[:username])
		pass_hash = password_hash(params[:password])
		attributes = {
			username: params[:username],
			password: pass_hash,
			first_name: params[:first_name],
			last_name: params[:last_name],
			address: params[:address],
			phone_number: params[:phone_number],
			email: params[:email],
			avatar: params[:avatar]
		}
		if current_user.access_token == @user.access_token
			if @user.update(attributes)
				render json: { user: @user.as_json(only: [:id, :username, :first_name, 
											:last_name, :address, :phone_number, :email, :avatar]) }, status: :ok
			else
				render json: { errors: "There was an issue with the specified field entries." }, 
				 							status: :unprocessable_entity
			end
		else
			render json: { message: "Unauthorized to modify this account." }, status: :unauthorized
		end
	end

	def delete
		@user = User.find_by(username: params[:username])
		if current_user.access_token == @user.access_token
			if @user.destroy
			  render json: { message: "Account Deleted." }, status: :no_content
      else
        render json: { errors: "Invalid Request." }, status: :bad_request 
      end
		else
			render json: { message: "Unauthorized to delete this account." }, status: :unauthorized
		end
	end

	def show
		@user = User.find_by(username: params[:username])
		if @user
			render json: { user: @user.as_json(only: [:id, :username, :first_name, 
										:last_name, :address, :phone_number, :email, :avatar])}, status: :ok
		else
			render json: { error: @user.errors.full_messages }, status: :bad_request
		end
	end

	private

	def password_hash(password)
		if password.nil? || password.length < 6
			hash = password
		else
			hash = Digest::SHA1.hexdigest(password)
		end
		hash
	end

end
