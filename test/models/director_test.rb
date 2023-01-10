require "test_helper"

class DirectorTest < ActiveSupport::TestCase

test "should not save director without name" do
  director = Director.new
  assert_not director.save
end
end
