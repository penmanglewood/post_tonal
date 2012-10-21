module PostTonal
	class PitchClassSet

		require 'post_tonal/pitch_class'

		attr_reader :pitch_classes

		def initialize(pitch_classes = nil)
			@pitch_classes = pitch_classes || []
			@normalized_pitch_classes = pitch_classes ? self.class.to_normal_form(@pitch_classes) : []
			@inverted_pitch_classes = pitch_classes ? invert(@pitch_classes) : []
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
				@normalized_pitch_classes = self.class.to_normal_form(@pitch_classes)
				@inverted_pitch_classes = invert(@pitch_classes)
			end

			pc
		end

		def eql?(pitch_class_set)
			return false if @pitch_classes.size != pitch_class_set.pitch_classes.size

			@normalized_pitch_classes.each_with_index do |pitch_class, i|
				return false if !pitch_class_set.normal_form.pitch_classes[i].eql?(pitch_class)
			end

			true
		end

		def ==(pitch_class_set)
			eql? pitch_class_set
		end

		def to_s
			"PitchClassSet: #{@pitch_classes}"
		end

		# Returns the normal form of an array of pitch classes
		def self.to_normal_form(pitch_classes)
			normal = pitch_classes.sort { |x, y| x.value <=> y.value }

			newLen = normal.last.value - normal.first.value
			newLen += 12 if newLen < 0
			newLen += 12 if newLen == 1 && normal.size > 2

			shortest = {:array => normal.dup, :length => newLen}

			0.upto(normal.size - 1) do |q|
				# Rotate
				normal.push normal.shift

				newLen = normal.last.value - normal.first.value
				newLen += 12 if newLen < 0
				newLen += 12 if newLen == 1 && normal.size > 2

				if newLen < shortest[:length]
					shortest = {:array => normal.dup, :length => newLen}
				elsif newLen == shortest[:length]
					(normal.size - 1).downto(q) do |r|

						newLen = normal[r].value - normal.first.value
						newLen += 12 if newLen < 0
						newLen += 12 if newLen == 1 && normal.size > 2

						sNewLen = shortest[:array][r].value - shortest[:array].first.value
						sNewLen += 12 if sNewLen < 0
						sNewLen += 12 if sNewLen == 1 && normal.size > 2

						if newLen < sNewLen
							shortest = {:array => normal.dup, :length => newLen}
							break
						end
					end
				end
			end

			shortest[:array]
		end

		# Returns a PitchClassSet of the inversino of the current PitchClassSet
		def inversion
			self.class.new(@inverted_pitch_classes)
		end

		# Returns a PitchClassSet of the current PitchClassSet in normal form
		def normal_form
			self.class.new(@normalized_pitch_classes)
		end

		# Transposes the set by a degree (integer)
		# Returns PitchClassSet of the transposed set
		def transpose(degree)
			transposed = self.class.new

			@pitch_classes.each do |pitch_class|
				oct = pitch_class.octave
				val = pitch_class.value

				val += degree

				oct += val / 12
				oct -= 1 if val < 0 && val % 12 == 0

				transposed.add_pitch(val, oct)
			end

			transposed
		end

		private

		# Inverts an array of pitch classes. The PitchClass attribute octave may become invalid after inversion.
		# Returns a PitchClassSet of the inverted pitch classes
		def invert(pitch_classes)
			inverted = []

			pitch_classes.each do |pitch_class|
				pc = PitchClass.new(12 - pitch_class.value, pitch_class.octave)
				inverted << pc
			end

			inverted
		end

	end
end