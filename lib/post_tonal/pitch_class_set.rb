module PostTonal
	class PitchClassSet

		require 'post_tonal/pitch_class'

		attr_reader :pitch_classes

		def initialize(pitch_classes = nil)
			@pitch_classes = pitch_classes || []
			@normalized_pitch_classes = @pitch_classes.size > 0 ? self.class.to_normal_form(@pitch_classes) : []
			@inverted_pitch_classes = @pitch_classes.size > 0 ? invert(@pitch_classes) : []
			@prime_pitch_classes = @pitch_classes.size > 0 ? to_prime_form : []
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
				@prime_pitch_classes = to_prime_form
			end

			pc
		end

		def eql?(pitch_class_set)
			return false if @pitch_classes.size != pitch_class_set.pitch_classes.size || @pitch_classes.size == 0

			@pitch_classes.each_with_index do |pitch_class, i|
				return false if !pitch_class.eql?(pitch_class_set.pitch_classes[i])
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

					rs = shortest[:array].reverse
					normal.reverse.each_with_index do |pitch_class, i|
						this_dist = (pitch_class.value - normal.first.value).abs
						that_dist = (rs[i].value - rs.last.value).abs

						if this_dist < that_dist
							shortest = {:array => normal, :length => newLen}
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

		# Returns a PitchClassSet of the current PitchClassSet in prime form
		def prime_form
			prime1 = normal_form.transpose_to_zero
			prime2 = inversion.normal_form.transpose_to_zero
			return prime2 if prime2.is_more_packed_than? prime1
			prime1
		end

		# Transposes the set
		# 
		# degree - The number of steps to transpose. May be positive or negative
		# reset_octave - If true, resets octave attribute to 0 for all pitch classes
		# 
		# Returns PitchClassSet of the transposed set
		def transpose(degree, reset_octave = false)
			transposed = self.class.new

			@pitch_classes.each do |pitch_class|
				oct = pitch_class.octave
				val = pitch_class.value

				val += degree

				if reset_octave
					oct = 0
				else
					oct += val / 12
					oct -= 1 if val < 0 && val % 12 == 0
				end

				transposed.add_pitch(val, oct)
			end

			transposed
		end

		def reset_octave
			ro = []

			@pitch_classes.each do |pitch_class|
				ro << PitchClass.new(pitch_class.value)
			end

			self.class.new(ro)
		end

		# Check if this pitch class set is more tightly packed to the left than the comparison pitch class set.
		#
		# Returns false if less tightly packed or if is the same set
		def is_more_packed_than?(pitch_class_set)
			return false if (@pitch_classes.size != pitch_class_set.pitch_classes.size || @pitch_classes.size == 0) || eql?(pitch_class_set)

			rpcs = pitch_class_set.pitch_classes.reverse
			@pitch_classes.reverse.each_with_index do |pitch_class, i|
				this_dist = (pitch_class.value - @pitch_classes.first.value).abs
				that_dist = (rpcs[i].value - rpcs.last.value).abs

				return true if this_dist < that_dist
			end

			false
		end

		protected

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

		# Returns the normal form of an array of pitch classes
		def to_prime_form
			#prime1 = normal_form.transpose_to_zero.pitch_classes
			#prime2 = inversion.normal_form.transpose_to_zero

			#return prime1.pitch_classes if prime1.is_more_packed_than? prime2
			#return prime2.pitch_classes_classes
			[]
		end

		def transpose_to_zero
			dist = 12 - @pitch_classes[0].value
			"TT0: #{@pitch_classes}, dist: #{dist}"
			return transpose(dist, true) if dist % 12 != 0
			self
		end

	end
end