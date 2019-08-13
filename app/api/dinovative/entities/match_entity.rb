module Dinovative::Entities
  class MatchEntity < Grape::Entity
    expose :id
    expose :match_code
    expose :venue
    expose :score
    expose :status do |obj|
      if obj.status_match.nil?
        {status: :equal}
      else
        UserEntity.represent(obj.status_match)
      end
    end
  end
end