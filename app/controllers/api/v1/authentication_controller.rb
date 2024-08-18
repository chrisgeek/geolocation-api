module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_user

      def login
        # debugger
        @user = User.find_by(email: params[:user][:email])
        if @user&.authenticate(params[:user][:password])
          token = encode({ user_id: @user.id })
          render json: { token: token, email: @user.email }, status: :ok
        else
          render json: { error: 'Invalid login details, try again' }, status: :not_found
        end
      end
    end
  end
end
