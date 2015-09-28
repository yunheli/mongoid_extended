# encoding: utf-8

unless defined?(ActiveSupport::Concern)
  require_relative './concern'
end

module MongoidExtended
  class << self
    # configure method is used for select extend modules
    # @example Use soft delete module and object id module
    #   MongoidExtend.configure(:SoftDelete, :ObjectId)
    def configure *module_names
      module_names.each do |module_name|
        if const_defined?(module_name)
          module_name.send(:configured)
        else
          raise NameError, "uninitialized constant `#{module_name}` in MongoidExtended"
        end
      end
    end
  end
end
