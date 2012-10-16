module PostTonal
	class PitchClassInterval

		attr_reader :pitch1, :pitch2, :ordered, :unordered

		def initialize(pitch1, pitch2)
			@pitch1 = pitch1
			@pitch2 = pitch2

			@ordered = calculate_ordered(pitch1, pitch2)
			@unordered =  calculate_unordered(pitch1, pitch2)
		end

		private

		def calculate_ordered(p1, p2)
			pitches = [p1, p2]

			if pitches[0].octave != pitches[1].octave
				pitches = pitches.sort { |x, y| y.octave <=> x.octave }
			else
				pitches = pitches.sort { |x, y| y.value <=> x.value }
			end

			(pitches[0].value + (12 * pitches[0].octave)) - (pitches[1].value + (12 * pitches[1].octave))
		end

		def calculate_unordered(p1, p2)
			(p1.value - p2.value).abs > 6 ? 12 - (p1.value - p2.value).abs : (p1.value - p2.value).abs
		end
	end
end