# encoding: utf-8

require 'test_helper'

class SoftDeleteTest < Minitest::Test
  def setup
    MongoidExtended.configure :SoftDelete
    TestMongoidExtended.send(:include, MongoidExtended::SoftDelete)

    @test_object = TestMongoidExtended.create!
  end

  def teardown
    @test_object.delete
  end

  def test_object_soft_delete_use_destroy
    @test_object.destroy

    assert_equal @test_object.deleted?, true
  end

  def test_object_sofe_deleted_is_frozen
    @test_object.destroy

    assert_raises RuntimeError do
      @test_object.touch
    end
  end
end
