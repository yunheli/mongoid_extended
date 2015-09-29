# encoding: utf-8

require_relative './concern' unless defined?(ActiveSupport::Concern)
require_relative './mongoid_extended/epoch_time'
require_relative './mongoid_extended/object_id'
require_relative './mongoid_extended/serializer'
require_relative './mongoid_extended/soft_delete'

module MongoidExtended
  class << self
    # configure method is used for select extend modules
    # @example Use soft delete module and object id module
    #   MongoidExtended.configure(:SoftDelete, :ObjectId)
    def configure *module_names
      module_names.each do |module_name|
        if const_defined?(module_name)
          Object.const_get("MongoidExtended::#{module_name}").send(:configured)
        else
          raise NameError, "uninitialized constant `#{module_name}` in MongoidExtended"
        end
      end
    end
  end
end
