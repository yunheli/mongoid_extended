# encoding: utf-8

require 'test_helper'

class EpochTimeTest < MongoidExtendedTest
  def setup
    MongoidExtended.configure :EpochTime
    @test_object = TestMongoidExtended.create!
  end

  def test_the_object_default_time_field_as_json_is_a_integer
    assert JSON.parse(@test_object.to_json)['created_at'].is_a?(Integer)
    assert JSON.parse(@test_object.to_json)['updated_at'].is_a?(Integer)
  end

  def test_the_object_custom_field_as_json_is_a_integer
    assert_equal nil, JSON.parse(@test_object.to_json)['test_at_1']
    assert_equal nil, JSON.parse(@test_object.to_json)['test_at_2']

    @test_object.update(test_at_1: Time.now.utc)
    @test_object.update(test_at_2: Time.now.utc)

    assert JSON.parse(@test_object.to_json)['test_at_1'].is_a?(Integer)
    assert JSON.parse(@test_object.to_json)['test_at_2'].is_a?(Integer)
  end
end
