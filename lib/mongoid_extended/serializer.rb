# encoding: utf-8

module MongoidExtended
  module Serializer
    class << self
      def configured
        unless defined?(::ActiveModel::SerializerSupport)
          raise MongoidExtended::GemsLoadError.new(:active_model_serializers)
        end

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
