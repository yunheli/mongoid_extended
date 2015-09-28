# encoding: utf-8

module MongoidExtended
  module ObjectId
    class << self
      def configured
        ::BSON::ObjectId.send(:prepend, HashRepresentation)
      end
    end

    # rewrite methods `BSON::ObjectId#as_json` & `BSON::ObjectId#to_json`
    # Return the object id as a JSON hash representation.
    #
    # @example Get the object id as JSON.
    #   object_id.as_json
    #
    # @return [ String ] The object id as a JSON string.
    #
    # @since 2.0.0
    module HashRepresentation
      def to_json
        to_s
      end

      def as_json
        to_s
      end
    end
  end
end
