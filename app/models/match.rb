class Match < ApplicationRecord
  has_one :user_match

  has_many :users, through: :user_matches
  has_many :scores

  belongs_to :group
  
  delegate :player1, to: :user_match, allow_nil: true
  delegate :player2, to: :user_match, allow_nil: true

end
