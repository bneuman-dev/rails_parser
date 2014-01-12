class Set
	def self.create
		initialize
	end

	attr_reader :contents

	def initialize(*contents)
		@contents = []
		contents.each { |x| add(x) }
	end

	def is_element_of(x)
		@contents.include? x
	end

	def is_empty?
		@contents.is_empty?
	end

	def size
		@contents.size
	end

	def iterate
		@contents.shuffle.each
	end

	def enumerate
		@contents.shuffle
	end

	def add(x)
		@contents.push(x) unless @contents.include? (x)
	end

	def remove(x)
		@contents.delete(x)
	end

	def union(set)
		(@contents + set.contents).uniq
	end

	def intersection(set)
		@contents.select { |x| set.include? x }
	end

	def pop
		@contents.shuffle.pop
	end

	def map
		@contents.shuffle.map { yield }
	end

	def filter
		@contents.select { yield }
	end
end



