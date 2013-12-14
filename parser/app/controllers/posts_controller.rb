require '/users/bneuman/rails-parser/parser/app/models/formatter/strippers'

class PostsController < ApplicationController
  def new
  end

  def create
  	sql_configure(DomainRule.all)
  	url = params[:posts][:url]
  	@post = Post.find_or_create_by_url(url)
  	if @post.f_html == nil
  		doc = HTML_Doc.new(url)
  		@post.html = doc.doc.serialize
  		@post.f_html = doc.processed_doc
  		@post.save
  	end

  	redirect_to @post
  end

  def show
  	@post = Post.find(params[:id])
  	render
  end

  def edit
    sql_configure(DomainRule.all)
    url = params[:url]
    @post = Post.find_or_create_by_url(url)
    if @post.html == nil
      doc = HTML_Doc.new(url)
      @post.html = doc.doc.serialize
      @post.f_html = doc.processed_doc
    else
      doc = Nokogiri::HTML(@post.html)
      f_html = Stripper.new(@post.url, doc).processed_doc
      if f_html != @post.f_html
        @post.f_html = f_html
      end
    end
    @post.save
    redirect_to @post
  end
end
