module PostTonal
	class PitchClassSet

		require 'post_tonal/pitch_class'

		attr_reader :pitch_classes, :normal_form

		def initialize
			@pitch_classes = []
			@normal_form = []
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

		def eql?(pitch_class_set)
			return false if @pitch_classes.size != pitch_class_set.pitch_classes.size

			@normal_form.each_with_index do |pitch_class, i|
				return false if !pitch_class_set.normal_form[i].eql?(pitch_class)
			end

			true
		end

		def ==(pitch_class_set)
			eql? pitch_class_set
		end

		def to_s
			"PitchClassSet: [#{@pitch_classes}]"
		end

		protected

		def normalize
			#puts "Normalize"
			normal = @pitch_classes.sort { |x, y| x.value <=> y.value }

			newLen = normal.last.value - normal.first.value
			newLen += 12 if newLen < 0
			newLen += 12 if newLen == 1 && normal.size > 2

			shortest = {:array => normal.dup, :length => newLen}

			#puts "Shortest a: #{shortest}"

			0.upto(normal.size - 1) do |q|
				#Rotate
				normal.push normal.shift

				newLen = normal.last.value - normal.first.value
				newLen += 12 if newLen < 0
				newLen += 12 if newLen == 1 && normal.size > 2

				if newLen < shortest[:length]
					shortest = {:array => normal.dup, :length => newLen}
					#puts "Shortest b: #{shortest}"
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
							#puts "Shortest c[#{newLen}]: #{shortest}"
							break
						end
					end
				end
			end

			@normal_form = shortest[:array]
		end

	end
end