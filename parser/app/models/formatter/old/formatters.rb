class Formatter
  def initialize(finder, delete=false)
    @finder = finder
    @delete = delete
  end
    
  def finder
    @finder
  end
    
  def find(nodeset)  #DEFAULT BEHAVIOR TO BE OVERRIDDEN
    finder.find(nodeset)
  end

  def format(nodeset)
    results = find(nodeset)

    if @delete == true
      remove_elements(results)
      return nodeset

    else
      return results
    end

  end

  def remove_elements(elements)
    elements.each do |element|
      element.children.remove
      element.remove
    end
  end
end

