class Dinovative::API < Grape::API
  format :json
  prefix :api

  mount ApiV1
  add_swagger_documentation
end
