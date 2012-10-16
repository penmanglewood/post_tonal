require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class PitchClassTest < Test::Unit::TestCase

	def test_valid_int_values
		(0..11).each do |i|
			@p = PostTonal::PitchClass.new(i)
			assert_equal(i, @p.value, "0-11 should be valid")
		end
	end

	def test_mod12_int_values
		(12..23).each do |i|
			@p = PostTonal::PitchClass.new(i)
			assert_equal(i-12, @p.value, "12-23 should be valid")
		end
	end

	def test_negative_int_values
		(-11..0).each do |i|
			@p = PostTonal::PitchClass.new(i)
			assert_equal(i.abs, @p.value, "(-11)-0 should count as 11-0")
		end
	end

	def test_valid_str_values
		PostTonal::NoteParser::NAME_TO_INT.each do |k, v|
			@p = PostTonal::PitchClass.new(k)
			@q = PostTonal::PitchClass.new(k.upcase)
			assert_equal(v, @p.value, "Note names should be valid 1")
			assert_equal(v, @q.value, "Note names should be valid 2")
		end
	end

	def test_invalid_str_values
		('h'..'z').each do |z|
			@p = PostTonal::PitchClass.new(z)
			assert_equal(nil, @p.value, "h-z should be invalid")
		end
	end

	def test_octave
		(0..11).each do |i|
			@p = PostTonal::PitchClass.new(i, i)
			assert_equal(i, @p.octave, "0-11 should be valid octave values")
		end
	end

end