class Score < ApplicationRecord
  belongs_to :match
  belongs_to :player, class_name: 'User', foreign_key: 'player_id'

  enum status: [:equal, :winner, :loser, :comming_soon]

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
            else
              Score.find_or_create_by( match_id: match.id,
                                      player_id: match.player1.id ).update! status: 3
              Score.find_or_create_by( match_id: match.id,
                                      player_id: match.player2.id ).update! status: 3
            end
          rescue ArgumentError
            loser = User.find_by(full_name: match.score.chomp(" gave up"))
            status1 = 1
            status2 = 2
            if loser == match.player1.full_name
              status1 = 2
              status2 = 1
            end
            Score.find_or_create_by( match_id: match.id, player_id: match.player1.id ).update! status: status1
            Score.find_or_create_by( match_id: match.id, player_id: match.player2.id ).update! status: status2
          end
        end
    end
  end
end
