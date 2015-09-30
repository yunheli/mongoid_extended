# encoding: utf-8

module MongoidExtended
  module SoftDelete
    class << self
      def configured
        instance_eval do
          extend ActiveSupport::Concern

          included do
            field :deleted_at, type: DateTime
            index({ deleted_at: -1 }, { background: true })
            scope :undeleted, -> { where(deleted_at: nil) }

            alias_method :destroy!, :destroy
          end
        end

        class_eval do
          define_method :destroy do
            run_callbacks(:destroy) do
              if persisted?
                set(deleted_at: Time.now.utc)
                set(updated_at: Time.now.utc)
              end
              @destroyed = true
            end
            freeze
          end

          define_method :deleted? do
            !deleted_at.blank?
          end
        end

        @configured = true
      end

      def configured?
        !!@configured
      end
    end
  end
end
