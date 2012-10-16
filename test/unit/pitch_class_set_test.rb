require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class PitchClassSetTest < Test::Unit::TestCase

	def setup
		@pitch_class_set = PostTonal::PitchClassSet.new
	end

	def teardown
		@pitch_class_set = nil
	end

	def test_duplicate_assignment
		@pitch_class_set.add_pitch(0)
		@pitch_class_set.add_pitch(0)
		@pitch_class_set.add_pitch(0)

		assert_equal(1, @pitch_class_set.pitch_classes.size)
	end

	def test_nonduplicate_assignment
		@pitch_class_set.add_pitch(0)
		@pitch_class_set.add_pitch(1)
		@pitch_class_set.add_pitch(0, 1)

		assert_equal(3, @pitch_class_set.pitch_classes.size)
	end

end