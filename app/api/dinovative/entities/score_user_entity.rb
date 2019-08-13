module Dinovative::Entities
  class ScoreUserEntity < Grape::Entity
    expose :total_score do |obj|
      obj.calc_score
    end
  end
end