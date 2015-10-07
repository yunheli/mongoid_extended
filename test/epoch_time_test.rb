# encoding: utf-8

require 'test_helper'

class EpochTimeTest < MongoidExtendedTest
  def setup
    MongoidExtended.configure :EpochTime
    @test_object = TestMongoidExtended.create!
  end

  def test_the_object_default_time_field_is_a_integer
    assert @test_object.created_at.is_a?(Integer)
    assert @test_object.updated_at.is_a?(Integer)
  end

  def test_the_object_custom_field_is_a_integer
    assert_equal nil, @test_object.test_at_1
    assert_equal nil, @test_object.test_at_2

    @test_object.update(test_at_1: Time.now.utc)
    @test_object.update(test_at_2: Time.now.utc)

    assert @test_object.test_at_1.is_a?(Integer)
    assert @test_object.test_at_2.is_a?(Integer)
  end
end
