module Dinovative::V1::Users
  class UserApi < Grape::API
    resources :user do 

      #====================================================================
      desc "Get info user"
      params do
        optional :email, type: String
        optional :full_name, type: String
      end
      get '/' do
        user = User.where(["email = '%s' and full_name = '%s'", params[:email], params[:full_name]]).last
        present_object user, with: Dinovative::Entities::UserEntity
      end
      #====================================================================

      #====================================================================
      desc "Edit user"
      params do
        requires :email, type: String
        optional :user, type: Hash do
          optional :full_name, type: String
          optional :email, type: String
          optional :password, type: String
        end
      end
      patch '/:email/edit' do
        user = User.find_by(email: params[:email])
        if user.present?
          user.update! params[:user] unless params[:user].nil?
          present_message("Update success!")
        end
      end
      #====================================================================
    end
  end
end
