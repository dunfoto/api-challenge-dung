class UserMatch < ApplicationRecord
  belongs_to :match
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"
  accepts_nested_attributes_for :player1, :player2
end
