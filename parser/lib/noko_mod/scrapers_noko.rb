module NokoHelper

	def nokoify(url)
		noko = Nokogiri::HTML(open(url))
		noko_as_string = noko.serialize()
	end
	
end
