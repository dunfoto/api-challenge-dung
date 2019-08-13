module Dinovative::V1::Users
  class Base < Grape::API
    mount UserApi
  end
end
