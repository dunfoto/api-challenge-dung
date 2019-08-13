require 'csv'
require 'date'
module Dinovative::V1
  class Import < Grape::API
    helpers do
      def import_data(file)
        ActiveRecord::Base.transaction do
          CSV.foreach(file["tempfile"], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all }) do |row|
            player_1 = User.find_by(full_name: row[3])
            player_2 = User.find_by(full_name: row[4])
            if player_1.nil?
              password_1 = Devise.friendly_token.first(6)
              player_1 = User.create!(full_name: row[3], email: row[3].downcase.parameterize.underscore.concat("@dinovative.com"), password: password_1)
              #Can send email info password and email for user create
            end
            if player_2.nil?
              password_2 = Devise.friendly_token.first(6)
              player_2 = User.create!(full_name: row[4], email: row[4].downcase.parameterize.underscore.concat("@dinovative.com"), password: password_2)
              #Can send email info password and email for user create
            end
            group = Group.find_or_create_by(name: row[1])
            if row[8].include? "gave up"
              score = row[8]
            else
              change_date_time(row[8])
              score = row[8].to_date
            end
            params_match = { match_code: row[2],
                            match_time: row[5].concat(":").concat(row[6]).to_datetime,
                            venue: row[7],
                            score: score,
                            group_id: group.id }
            match = Match.find_or_create_by(params_match)
            UserMatch.find_or_create_by(match_id: match.id, player1_id: player_1.id, player2_id: player_2.id)
            Rails.logger.info "Import Success"
          end
        rescue
          false
        end
      end
    end
    desc "Import file for data"
    params do
      requires :file, type: File
    end
    post :import do
      if import_data(params[:file])
        present_message("Success Import")
      end
    end
  end
end
