# encoding: utf-8

require 'test_helper'

class ObjectIdTest < MongoidExtendedTest
  def setup
    MongoidExtended.configure :ObjectId
    @test_object = TestMongoidExtended.create!
  end

  def test_object_id_is_as_hash_representation
    assert_equal @test_object.id.to_s, JSON.parse(@test_object.to_json)['_id']
  end
end
