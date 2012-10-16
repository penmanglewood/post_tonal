module PostTonal
	class PitchClass

		require 'post_tonal/note_parser'

		attr_reader :value, :octave

		def initialize(note_name_or_integer, octave = 0)
			@value = NoteParser.integer_value(note_name_or_integer)
			@octave = octave
		end
	end
end