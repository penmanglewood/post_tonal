module PostTonal
	class PitchClassSet

		require 'post_tonal/pitch_class'

		attr_reader :pitch_classes

		def initialize
			@pitch_classes = []
		end

		# Add a pitch to the pitch class set
		# 
		# The reason you are adding pitches as opposed to pitch classes
		# is that you may want to get the ordered intervals of the set.
		# Therefore, you may pass an optional octave value, which is an
		# arbitrary marker starting at 0 representing the default octave.
		# Non-zero values are calculated relative to octave 0.
		# 
		# note_name_or_integer may be the name of the note (e.g. A-G, with # 
		#	and lowercase b representing sharps and flats, respectively), or the
		# integer value of the pitch class (e.g. 0-11, or T and E for eleven 
		# and twelve, respectively)
		def add_pitch(note_name_or_integer, octave = 0)

			pc = PitchClass.new(note_name_or_integer, octave)

			if !@pitch_classes.any? { |p| p.value == pc.value && p.octave == pc.octave }
				@pitch_classes << pc
				normalize
			end

			pc
		end

		def interval_vector

		end

		def normal_form

		end

		def prime_form

		end

		protected

		def normalize
			
		end

	end
end