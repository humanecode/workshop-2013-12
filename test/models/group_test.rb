require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def test_can_be_valid
    group = groups :payroll
    assert group.valid?
  end

  def test_validates_name
    group = groups :payroll
    group.name = nil
    refute group.valid?
    assert_includes group.errors[:name], "can't be blank"
  end
end
