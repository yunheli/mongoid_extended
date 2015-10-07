$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'mongoid_extended'
require 'minitest/autorun'

Mongoid.load!(File.expand_path('../mongoid.yml', __FILE__), :test)

class TestMongoidExtended
  include Mongoid::Document
  include Mongoid::Timestamps

  field :test_at_1, type: Time
  field :test_at_2, type: DateTime
end
