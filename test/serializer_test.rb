# encoding: utf-8

require 'test_helper'

class SerializerTest < Minitest::Test
  def setup
    MongoidExtended.configure :Serializer, :ObjectId
    @test_object = TestMongoidExtended.create!
  end

  def teardown
    @test_object.delete
  end

  class TestMongoidExtendedSerializer < ::ActiveModel::Serializer
    attributes :id, :test_at_1, :created_at
  end

  def test_mongoid_serializer_works
  end
end
