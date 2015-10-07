# encoding: utf-8

require 'test_helper'

class SoftDeleteTest < MongoidExtendedTest
  def setup
    MongoidExtended.configure :SoftDelete
    TestMongoidExtended.send(:include, MongoidExtended::SoftDelete)
    @test_object = TestMongoidExtended.create!
  end

  def test_object_soft_delete_use_destroy
    @test_object.destroy

    assert_equal @test_object.deleted?, true
  end

  def test_object_deleted_at
    @test_object.destroy
    time = @test_object.updated_at.to_i

    assert_equal @test_object.deleted_at.to_i, time
  end

  def test_object_sofe_deleted_is_frozen
    @test_object.destroy

    assert_raises RuntimeError do
      @test_object.touch
    end
  end

  def test_class_has_a_deleted_at_index
    index = TestMongoidExtended.index_specifications.first

    assert_equal index.key, { deleted_at: -1 }
    assert_equal index.options, { background: true }
  end

  def test_class_has_a_undeleted_scope
    assert_equal TestMongoidExtended.count, 1

    @test_object.destroy

    assert_equal TestMongoidExtended.count, 1
    assert_equal TestMongoidExtended.undeleted.count, 0
  end
end
