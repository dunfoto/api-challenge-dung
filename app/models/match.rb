class Match < ApplicationRecord
  has_one :user_match

  has_many :users, through: :user_matches
  has_many :scores, dependent: :destroy

  belongs_to :group
  
  delegate :player1, to: :user_match, allow_nil: true
  delegate :player2, to: :user_match, allow_nil: true

  def status_match
    if scores[0].status == 'winner'
      return scores[0].player
    elsif scores[0].status == 'loser'
      return scores[1].player
    end
  end

end
