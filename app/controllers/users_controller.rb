class UsersController < ApplicationController
    before_action :authorize, only: :show
    def create
        user = User.create(user_params)
        session[:user_id] = user.id
        if user.valid?
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: User.find_by(id: session[:user_id]),status: :ok
    end
    
      private
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end

    def authorize
        render json: {error: "Not authorized"}, status: :unauthorized   unless session.include? :user_id
    end

end
