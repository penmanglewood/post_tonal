module PostTonal
	class PitchClass

		require 'post_tonal/note_parser'

		attr_reader :value, :octave

		def initialize(note_name_or_integer, octave = 0)
			@value = NoteParser.integer_value(note_name_or_integer)
			@octave = octave
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