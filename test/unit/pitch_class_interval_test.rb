require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class PitchClassIntervalTest < Test::Unit::TestCase

	def test_unordered_intervals
		(0..11).each do |i|
			@p1 = PostTonal::PitchClass.new(i)
			(0..11).each do |j|
				@p2 = PostTonal::PitchClass.new(j)
				@interval = PostTonal::PitchClassInterval.new(@p1, @p2)
				expected = (@p1.value - @p2.value).abs > 6 ? 12 - (@p1.value - @p2.value).abs : (@p1.value - @p2.value).abs
				assert_equal(expected, @interval.unordered, "p1: #{i}, p2: #{j}") if i != j
			end
		end
	end

	def test_ordered_intervals

		#Same octave ordered intervals
		(0..11).each do |i|
			@p1 = PostTonal::PitchClass.new(i)
			(0..11).each do |j|
				@p2 = PostTonal::PitchClass.new(j)
				@interval = PostTonal::PitchClassInterval.new(@p1, @p2)
				expected = j > i  ? @p2.value - @p1.value : @p1.value - @p2.value
				assert_equal(expected, @interval.ordered, "p1: #{i}, p2: #{j}") if i != j
			end
		end

		#Cross-octave ordered intervals
		@p3 = PostTonal::PitchClass.new(11)
		(0...11).each do |j|
			@p4 = PostTonal::PitchClass.new(j, 1)
			@interval = PostTonal::PitchClassInterval.new(@p3, @p4)
			assert_equal(j+1, @interval.ordered, "Cross-Octave p1: 11, p2: #{j}")
		end
	end
end