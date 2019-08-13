module Dinovative::Helpers
  module PresenterHelper
    def present_object(object, *agrs)
      present :data, object, *agrs
    end
  end
end