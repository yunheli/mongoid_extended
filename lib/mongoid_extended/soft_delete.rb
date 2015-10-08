# encoding: utf-8

module MongoidExtended
  module SoftDelete
    extend ActiveSupport::Concern

    included do
      field :deleted_at, type: DateTime
      index({ deleted_at: -1 }, { background: true })
      scope :undeleted, -> { where(deleted_at: nil) }

      alias_method :destroy!, :destroy
    end

    def destroy
      run_callbacks(:destroy) do
        if persisted?
          set(deleted_at: Time.now.utc)
          set(updated_at: Time.now.utc) if respond_to?(:updated_at)
        end
        @destroyed = true
      end
      freeze
    end

    def deleted?
      !deleted_at.blank?
    end

    class << self
      def configured
        @configured = true
      end

      def configured?
        !!@configured
      end
    end
  end
end
