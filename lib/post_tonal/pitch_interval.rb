module PostTonal
	class PitchInterval

		attr_reader :pitch1, :pitch2

		def initialize(pitch1, pitch2)
			@pitch1 = pitch1
			@pitch2 = pitch2
		end

		def ordered
			pitch1.int_value - pitch2.int_value
		end

		def unordered
			(pitch1.int_value - pitch2.int_value).abs
		end
	end
end