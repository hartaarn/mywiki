class Content < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :page

  #before_save :create_wikilinks


  def create_wikilinks
    #pattern = Regexp.new('\[\[([a-zA-Z]+)\]\]')
    #pattern = Regexp.new(/\[{2}([a-z]*?)\]{2}/)
    pattern = Regexp.new(/\[\[([a-zA-Z]*?)\]\]/)
    self.body = self.body.gsub(pattern) {|match| Page.page_url_with_title($1) }
    #puts link_converted_text
    #link_converted_text = self.body.gsub(pattern) { link_to( $1, Page.search_match_title($1) ) }
    #self.body = self.body.gsub(/\[{2}([a-z]*?)\]{2}/) { |match| link_to Page.search_match_title($1) }
  end
end
