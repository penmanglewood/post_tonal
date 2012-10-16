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

	def test_equality
		@pitch_class_set.add_pitch(0)
		@pitch_class_set.add_pitch(1)
		@pitch_class_set.add_pitch(2)

		@p1 = PostTonal::PitchClassSet.new
		@p1.add_pitch(0)
		@p1.add_pitch(1)
		@p1.add_pitch(2)

		assert(@pitch_class_set.eql?(@p1), "eql? should be true")
		assert(@pitch_class_set == @p1, "== should be true")
	end

	def test_normal_form

		@p1 = PostTonal::PitchClassSet.new
		@p1.add_pitch(0)
		@p1.add_pitch(1)
		@p1.add_pitch(2)

		[0,1,2].each do |n|
			assert_equal(@p1.pitch_classes[n], @p1.normal_form[n])
		end

		@p2 = PostTonal::PitchClassSet.new
		@p2.add_pitch(0)
		@p2.add_pitch(10)
		@p2.add_pitch(11)

		[10,11,0].each_with_index do |n, i|
			assert_equal(n, @p2.normal_form[i].value)
		end

		@p3 = PostTonal::PitchClassSet.new
		@p3.add_pitch(0)
		@p3.add_pitch(3)
		@p3.add_pitch(4)
		@p3.add_pitch(9)

		[9,0,3,4].each_with_index do |n, i|
			assert_equal(n, @p3.normal_form[i].value)
		end

		@p4 = PostTonal::PitchClassSet.new
		@p4.add_pitch(0)
		@p4.add_pitch(3)
		@p4.add_pitch(4)
		@p4.add_pitch(8)

		[0,3,4,8].each_with_index do |n, i|
			assert_equal(n, @p4.normal_form[i].value)
		end

		@p5 = PostTonal::PitchClassSet.new
		@p5.add_pitch(0)
		@p5.add_pitch(1)
		@p5.add_pitch(10)
		@p5.add_pitch(11)

		[10,11,0,1].each_with_index do |n, i|
			assert_equal(n, @p5.normal_form[i].value)
		end

		@p6 = PostTonal::PitchClassSet.new
		@p6.add_pitch(0)
		@p6.add_pitch(1)
		@p6.add_pitch(8)
		@p6.add_pitch(4)

		[0,1,4,8].each_with_index do |n, i|
			assert_equal(n, @p6.normal_form[i].value)
		end

		@p7 = PostTonal::PitchClassSet.new
		@p7.add_pitch(0)
		@p7.add_pitch(3)
		@p7.add_pitch(6)
		@p7.add_pitch(9)

		[0,3,6,9].each_with_index do |n, i|
			assert_equal(n, @p7.normal_form[i].value)
		end

		@p7 = PostTonal::PitchClassSet.new
		@p7.add_pitch(0)
		@p7.add_pitch(6)
		@p7.add_pitch(7)

		[6,7,0].each_with_index do |n, i|
			assert_equal(n, @p7.normal_form[i].value)
		end
	end

end