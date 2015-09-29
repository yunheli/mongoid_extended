# encoding: utf-8

module MongoidExtended
  module EpochTime
    class << self
      def configured
        ::Time.send(:extend, TimeDemongoize)
        ::DateTime.send(:extend, DateTimeDemongoize)
      end
    end

    # Convert the object from its mongo friendly ruby type to this type.
    #
    # @example Demongoize the object.
    #   Time.demongoize(object)
    #
    # @param [ Time ] object The time from Mongo.
    #
    # @return [ Integer ] The object as a integer.
    #
    # @since 3.0.0
    module TimeDemongoize
      def demongoize(object)
        result = super
        result.nil? ? nil : result.to_i
      end
    end

    # Convert the object from its mongo friendly ruby type to this type.
    #
    # @example Demongoize the object.
    #   DateTime.demongoize(object)
    #
    # @param [ DateTime ] object The time from Mongo.
    #
    # @return [ Integer ] The object as a integer.
    #
    # @since 3.0.0
    module DateTimeDemongoize
      def demongoize(object)
        ::Time.demongoize(object)
      end
    end
  end
end
