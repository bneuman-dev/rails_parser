class Text_Formatter
  def format(body)
    body = remove_comments(body)
    body = make_body_text_only(body)
    body = restore_links(body)
    body = sanitize(body)
    body = fix_p_tags(body)
    body = join_body_together(body)
  end

  def remove_comments(body)
    comments = find_comments(body)
    comments.each {|comment| comment.remove}
    body
  end

  def find_comments(body)
    body.search('.//comment()')
  end

  def make_body_text_only(body)
    body.search('.//text()')
  end

  def restore_links(body)
    #Hopefully we can still look at text nodes parents here
    body.collect { |text_node| restore_link(text_node) }
  end

  def restore_link(text_node)
    if text_node.parent.name == "a"   #should this be in restore_link method? nah...
        link_up_text(text_node)  #previously had text_node =   in both if and else, hope no breakage
        
    else
        text_node.text 
    end
  end

  def link_up_text(text_node)
    unless text_node.parent['href'] == nil
      "<a href='" + text_node.parent['href'] + "'>" + text_node.text + "</a>"

    else
      text_node.text
    end

  end

  def sanitize(body)
    body.collect {|text| sanitize_utf8(text)}
  end
  
  def sanitize_utf8(string)
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

  def fix_p_tags(body)
    body.collect {|text| text.gsub("\n", "<p>")}
  end

  def join_body_together(body)
    body.join(' ')
  end
end