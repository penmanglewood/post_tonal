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
			assert_equal(@p1.pitch_classes[n], @p1.normal_form.pitch_classes[n])
		end

		@p2 = PostTonal::PitchClassSet.new
		@p2.add_pitch(0)
		@p2.add_pitch(10)
		@p2.add_pitch(11)

		[10,11,0].each_with_index do |n, i|
			assert_equal(n, @p2.normal_form.pitch_classes[i].value)
		end

		@p3 = PostTonal::PitchClassSet.new
		@p3.add_pitch(0)
		@p3.add_pitch(3)
		@p3.add_pitch(4)
		@p3.add_pitch(9)

		[9,0,3,4].each_with_index do |n, i|
			assert_equal(n, @p3.normal_form.pitch_classes[i].value)
		end

		@p4 = PostTonal::PitchClassSet.new
		@p4.add_pitch(0)
		@p4.add_pitch(3)
		@p4.add_pitch(4)
		@p4.add_pitch(8)

		[0,3,4,8].each_with_index do |n, i|
			assert_equal(n, @p4.normal_form.pitch_classes[i].value)
		end

		@p5 = PostTonal::PitchClassSet.new
		@p5.add_pitch(0)
		@p5.add_pitch(1)
		@p5.add_pitch(10)
		@p5.add_pitch(11)

		[10,11,0,1].each_with_index do |n, i|
			assert_equal(n, @p5.normal_form.pitch_classes[i].value)
		end

		@p6 = PostTonal::PitchClassSet.new
		@p6.add_pitch(0)
		@p6.add_pitch(1)
		@p6.add_pitch(8)
		@p6.add_pitch(4)

		[0,1,4,8].each_with_index do |n, i|
			assert_equal(n, @p6.normal_form.pitch_classes[i].value)
		end

		@p7 = PostTonal::PitchClassSet.new
		@p7.add_pitch(0)
		@p7.add_pitch(3)
		@p7.add_pitch(6)
		@p7.add_pitch(9)

		[0,3,6,9].each_with_index do |n, i|
			assert_equal(n, @p7.normal_form.pitch_classes[i].value)
		end

		@p7 = PostTonal::PitchClassSet.new
		@p7.add_pitch(0)
		@p7.add_pitch(6)
		@p7.add_pitch(7)

		[6,7,0].each_with_index do |n, i|
			assert_equal(n, @p7.normal_form.pitch_classes[i].value)
		end

		@p8 = PostTonal::PitchClassSet.new
		@p8.add_pitch(0)
		@p8.add_pitch(3)
		@p8.add_pitch(8)
		@p8.add_pitch(9)

		@p8n = PostTonal::PitchClassSet.new
		@p8n.add_pitch(8)
		@p8n.add_pitch(9)
		@p8n.add_pitch(0)
		@p8n.add_pitch(3)

		assert_equal(@p8n, @p8.normal_form, "Normal form of #{@p8} should be #{@p8n}")
	end

	def test_inversion
		@p1 = PostTonal::PitchClassSet.new
		0.upto(11) do |i|
			@p1.add_pitch(i)
		end

		@p1i = PostTonal::PitchClassSet.new
		@p1i.add_pitch(0)
		11.downto(1) do |i|
			@p1i.add_pitch(i)
		end

		assert_equal(@p1i, @p1.inversion, "Should be inverted")
	end

	def test_transposition
		@p1 = PostTonal::PitchClassSet.new
		0.upto(11) do |i|
			@p1.add_pitch(i)
		end

		#transposition degree
		0.upto(200) do |t|
			@p1t = PostTonal::PitchClassSet.new
			t.upto(t+11) do |i|
				oct = 0
				oct = i / 12
				oct -= 1 if i < 0 && i % 12 == 0

				@p1t.add_pitch(i, oct)
			end

			assert_equal(@p1t, @p1.transpose(t), "Should transpose #{t} degrees")
		end
	end

	def test_prime_form
		@p1 = PostTonal::PitchClassSet.new
		@p1.add_pitch(0)
		@p1.add_pitch(1)
		@p1.add_pitch(4)
		@p1.add_pitch(7)

		@p1p = PostTonal::PitchClassSet.new
		@p1p.add_pitch(0)
		@p1p.add_pitch(1)
		@p1p.add_pitch(4)
		@p1p.add_pitch(7)

		assert_equal(@p1p, @p1.prime_form)


		@p2 = PostTonal::PitchClassSet.new
		@p2.add_pitch(6)
		@p2.add_pitch(7)
		@p2.add_pitch(8)

		@p2p = PostTonal::PitchClassSet.new
		@p2p.add_pitch(0)
		@p2p.add_pitch(1)
		@p2p.add_pitch(2)

		assert_equal(@p2p, @p2.prime_form)

		@p3 = PostTonal::PitchClassSet.new
		@p3.add_pitch(0)
		@p3.add_pitch(3)
		@p3.add_pitch(8)
		@p3.add_pitch(9)

		@p3p = PostTonal::PitchClassSet.new
		@p3p.add_pitch(0)
		@p3p.add_pitch(1)
		@p3p.add_pitch(4)
		@p3p.add_pitch(7)

		assert_equal(@p3p, @p3.prime_form)


		@p4 = PostTonal::PitchClassSet.new
		@p4.add_pitch(1)
		@p4.add_pitch(5)
		@p4.add_pitch(6)
		@p4.add_pitch(7)

		@p4p = PostTonal::PitchClassSet.new
		@p4p.add_pitch(0)
		@p4p.add_pitch(1)
		@p4p.add_pitch(2)
		@p4p.add_pitch(6)

		assert_equal(@p4p, @p4.prime_form)

		@p5 = PostTonal::PitchClassSet.new
		@p5.add_pitch(0)
		@p5.add_pitch(2)
		@p5.add_pitch(4)
		@p5.add_pitch(7)
		@p5.add_pitch(11)

		@p5p = PostTonal::PitchClassSet.new
		@p5p.add_pitch(0)
		@p5p.add_pitch(1)
		@p5p.add_pitch(3)
		@p5p.add_pitch(5)
		@p5p.add_pitch(8)

		assert_equal(@p5p, @p5.prime_form)

		@p6 = PostTonal::PitchClassSet.new
		@p6.add_pitch(3)
		@p6.add_pitch(6)
		@p6.add_pitch(7)
		@p6.add_pitch(8)
		@p6.add_pitch(9)
		@p6.add_pitch(10)

		@p6p = PostTonal::PitchClassSet.new
		@p6p.add_pitch(0)
		@p6p.add_pitch(1)
		@p6p.add_pitch(2)
		@p6p.add_pitch(3)
		@p6p.add_pitch(4)
		@p6p.add_pitch(7)

		assert_equal(@p6p, @p6.prime_form)

		@p7 = PostTonal::PitchClassSet.new
		@p7.add_pitch(0)
		@p7.add_pitch(2)
		@p7.add_pitch(5)
		@p7.add_pitch(6)
		@p7.add_pitch(7)
		@p7.add_pitch(9)
		@p7.add_pitch(10)
		@p7.add_pitch(11)

		@p7p = PostTonal::PitchClassSet.new
		@p7p.add_pitch(0)
		@p7p.add_pitch(1)
		@p7p.add_pitch(2)
		@p7p.add_pitch(4)
		@p7p.add_pitch(5)
		@p7p.add_pitch(6)
		@p7p.add_pitch(7)
		@p7p.add_pitch(9)

		assert_equal(@p7p, @p7.prime_form)
	end
end