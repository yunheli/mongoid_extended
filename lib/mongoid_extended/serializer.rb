# encoding: utf-8

module MongoidExtended
  module Serializer
    class << self
      def configured
        ::Mongoid::Document.send(:include, ActiveModel::SerializerSupport)
        ::Mongoid::Criteria.delegate(:active_model_serializer, to: :to_a)

        @configured = true
      end

      def configured?
        !!@configured
      end
    end
  end
end
