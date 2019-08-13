module Dinovative::Helpers
  module PresenterHelper
    def present_object(object, *agrs)
      present :data, object, *agrs
    end
    def present_message(message)
      present :message, message
    end
  end
end