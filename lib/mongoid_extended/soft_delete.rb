# encoding: utf-8

module MongoidExtended
  module SoftDelete
    class << self
      def configured
        add_class_method
        add_instance_method

        @configured = true
      end

      def configured?
        !!@configured
      end

      def add_class_method
        instance_eval do
          extend ActiveSupport::Concern

          included do
            field :deleted_at, type: DateTime
            index({ deleted_at: -1 }, { background: true })
            scope :undeleted, -> { where(deleted_at: nil) }

            alias_method :destroy!, :destroy
          end
        end
      end

      # Object.destroy is soft deleted
      # Object.delete is hard deleted
      def add_instance_method
        class_eval do
          define_method :destroy do
            run_callbacks(:destroy) do
              if persisted?
                set(deleted_at: Time.now.utc)
                set(updated_at: Time.now.utc) if respond_to?(:updated_at)
              end
              @destroyed = true
            end
            freeze
          end

          define_method :deleted? do
            !deleted_at.blank?
          end
        end
      end
    end
  end
end
