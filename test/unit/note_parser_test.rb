require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class NoteParserTest < Test::Unit::TestCase

	def test_valid_int_values
		(0..11).each do |i|
			@p = PostTonal::NoteParser.integer_value(i)
			assert_equal(i, @p, "0-11 should be valid")
		end
	end

	def test_mod12_int_values
		(12..23).each do |i|
			@p = PostTonal::NoteParser.integer_value(i)
			assert_equal(i-12, @p, "12-23 should be valid")
		end
	end

	def test_negative_int_values
		(-11..0).each do |i|
			@p = PostTonal::NoteParser.integer_value(i)
			assert_equal(i.abs, @p, "(-11)-0 should count as 11-0")
		end
	end

	def test_valid_str_values
		PostTonal::NoteParser::NAME_TO_INT.each do |k, v|
			@p = PostTonal::NoteParser.integer_value(k)
			@q = PostTonal::NoteParser.integer_value(k.upcase)
			assert_equal(v, @p, "Note names should be valid 1")
			assert_equal(v, @q, "Note names should be valid 2")
		end
	end

	def test_invalid_str_values
		('h'..'z').each do |z|
			@p = PostTonal::NoteParser.integer_value(z)
			assert_equal(nil, @p, "h-z should be invalid")
		end
	end

	def test_note_names
		assert_equal('c', PostTonal::NoteParser.note_name(0), '0 should be c')
		assert_equal('c#', PostTonal::NoteParser.note_name(1), '1 should be c#')
		assert_equal('d', PostTonal::NoteParser.note_name(2), '2 should be d')
		assert_equal('d#', PostTonal::NoteParser.note_name(3), '3 should be d#')
		assert_equal('e', PostTonal::NoteParser.note_name(4), '4 should be e')
		assert_equal('f', PostTonal::NoteParser.note_name(5), '5 should be f')
		assert_equal('f#', PostTonal::NoteParser.note_name(6), '6 should be f#')
		assert_equal('g', PostTonal::NoteParser.note_name(7), '7 should be g')
		assert_equal('g#', PostTonal::NoteParser.note_name(8), '8 should be g#')
		assert_equal('a', PostTonal::NoteParser.note_name(9), '9 should be a')
		assert_equal('a#', PostTonal::NoteParser.note_name(10), '10 should be a#')
		assert_equal('b', PostTonal::NoteParser.note_name(11), '11 should be b')
	end
end