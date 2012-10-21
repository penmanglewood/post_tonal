module PostTonal
	class PitchClass

		require 'post_tonal/note_parser'

		# value - The integer value of a pitch class, with C as 0.
		# octave - A relative marker denoting the octave of the pitch class. Defaults to 0.
		attr_reader :value, :octave

		def initialize(note_name_or_integer, octave = 0)
			@value = NoteParser.integer_value(note_name_or_integer)
			@octave = octave
		end

		def value=(val)
			v = val
			v -= 12 while v > 11
			v += 12 while v < 0

			@value = v

			@value
		end

		def to_s
			"[#{@value}, oct.#{@octave}]"
		end

		def eql?(pitch_class)
			return pitch_class.value == @value && pitch_class.octave == @octave
		end

		def ==(pitch_class)
			eql? pitch_class
		end
	end
end