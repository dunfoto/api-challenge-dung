module Dinovative::V1::Matchs
  class MatchApi < Grape::API
    resources :match do 

      #====================================================================
      desc "Get info match"
      params do
        requires :match_code, type: String
      end
      get '/:match_code' do
        match = Match.find_by(match_code: params[:match_code])
        present_object match, with: Dinovative::Entities::MatchEntity
      end
      #====================================================================

      #====================================================================
      desc "Get list match"
      params do
        requires :start_time, type: DateTime
        requires :end_time, type: DateTime
      end
      get '/' do
        match = Match.where(match_time: params[:start_time].beginning_of_day..params[:end_time].end_of_day)
        present_object match, with: Dinovative::Entities::MatchEntity
      end
      #====================================================================

      #====================================================================
      desc "Destroy match need code, time and venue for destroy correct"
      params do
        requires :match_code, type: String
        requires :match_time, type: DateTime
        requires :venue, type: String
      end
      delete '/:match_code/destroy' do
        match = Match.where(["match_code = '%s' and match_time = '%s' and venue = '%s", params[:match_code], params[:match_time]], params[:venue])
        if match.destroy_all
          present_message("Destroy success")
        else
          present_message("Destroy fail")
        end
      end
      #====================================================================

    end
  end
end
