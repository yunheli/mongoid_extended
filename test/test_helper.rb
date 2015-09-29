$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'mongoid_extended'
require 'minitest/autorun'
require 'mongoid'

Mongoid.load!(File.expand_path('../mongoid.yml', __FILE__), :test)

class TestMongoidExtended
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String, default: 'test'
end
