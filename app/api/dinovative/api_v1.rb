class Dinovative::ApiV1 < Grape::API
  version 'v1', using: :path, vender: 'Ben Trinh'

  helpers Dinovative::Helpers::PresenterHelper
  helpers Dinovative::Helpers::DatetimeHelper

  mount Dinovative::V1::Users::Base
  mount Dinovative::V1::Matchs::Base
  mount Dinovative::V1::Import

  route :any, '*path' do
    error!({ message: "The api you were looking for doesn't exist", code: 3001, status: false }, 404)
  end
end