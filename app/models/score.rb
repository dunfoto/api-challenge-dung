class Score < ApplicationRecord
  belongs_to :match
  belongs_to :player, class_name: 'User'

  enum status: [:equal, :winner, :loser]

  def self.calc_score
    Match.all.each do |match|
      if match.scores.count < 2
        begin
          DateTime.parse(match.score)
          if match.score.to_date >= match.match_time.to_date
            Score.find_or_create_by( match_id: match.id,
                          player_id: match.player1.id ).update! status: 0
            Score.find_or_create_by( match_id: match.id,
                          player_id: match.player2.id ).update! status: 0
          end
        rescue ArgumentError
          loser = User.find_by(full_name: match.score.chomp(" gave up"))
          if loser == match.player1.full_name
            Score.find_or_create_by( match_id: match.id,
                          player_id: match.player1.id ).update! status: 2
          else
            Score.find_or_create_by( match_id: match.id,
                          player_id: match.player2.id ).update! status: 1
          end
        end
      end
    end
  end
end
