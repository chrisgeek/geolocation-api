module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        user = User.create(user_params)
        if user.save
          success_response(user, UserSerializer, :created)
        else
          failure_response(user.errors.full_messages)
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
