module Dinovative::Helpers
  module DatetimeHelper
    def change_date_time(value)
      value.gsub! "-", "/"
    end
  end
end