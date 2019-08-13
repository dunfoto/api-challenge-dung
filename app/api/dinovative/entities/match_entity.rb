module Dinovative::Entities
  class MatchEntity < Grape::Entity
    expose :id
    expose :match_code
    expose :venue
    expose :score
  end
end