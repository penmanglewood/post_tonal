module PostTonal
	class NoteParser

		NAME_TO_INT = {	:'b#' => 0, :'c' => 0, 
										:'c#' => 1, :'db' => 1, 
										:'d' => 2, 
										:'d#' => 3, :'eb' => 3, 
										:'e' => 4, :'fb' => 4, 
										:'e#' => 5, :'f' => 5, 
										:'f#' => 6, :'gb' => 6, 
										:'g' => 7, 
										:'g#' => 8, :'ab' => 8,
										:'a' => 9,
										:'a#' => 10, :'bb' => 10,
										:'b' => 11, :'cb' => 11}

		INT_TO_NAME = ['c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b']
		INT_TO_NAME_FLAT = ['c', 'db', 'd', 'eb', 'e', 'f', 'gb', 'g', 'ab', 'a', 'bb', 'b']

		def self.integer_value(name_or_integer)
			return name_or_integer.abs % 12 if name_or_integer.class == Fixnum
			return NAME_TO_INT[name_or_integer.downcase.to_sym]
		end

		def self.note_name(name_or_integer)
			return INT_TO_NAME[(name_or_integer.abs % 12)] if name_or_integer.class == Fixnum
			return name_or_integer.downcase if NAME_TO_INT.has_key?(name_or_integer.downcase.to_sym)
		end
	end
end