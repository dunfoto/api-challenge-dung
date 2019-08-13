module Dinovative::Entities
  class UserEntity < Grape::Entity
    expose :id
    expose :full_name
    expose :email
  end
end