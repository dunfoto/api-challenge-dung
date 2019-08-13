class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_matches
  has_many :matches, through: :user_matches
  has_many :scores, foreign_key: 'player_id'
  
  def calc_score
    total_score = 0
    scores.each do |score|
      case score.status
      when "equal"
        total_score += 1
      when "winner"
        total_score += 3
      end
    end
    total_score
  end

end
