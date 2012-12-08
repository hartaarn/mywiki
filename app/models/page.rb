class Page < ActiveRecord::Base  
	include Rails.application.routes.url_helpers
  #attr_accessible :title
  attr_accessor :body

  belongs_to :user, foreign_key: :created_by
  has_many :contents
  has_many :tags, through: :tag_mappings

  validates :title, presence: true, uniqueness: :true

  #after_initialize :init
  

  def current_body
    contents.order('created_at  desc').limit(1).first.body
  end

  def revision_history revision = nil, limit = 5
    limit < 0 ? 0 : limit
    if revision
      limit = 1
      history = contents.find(:all, :conditions => ['id = ?', "#{revision.id}"], :order => ['created_at'], :limit => limit).first
    else
      history = contents.order("created_at desc").limit(limit)
    end
    history.count <= 1 ? nil : history
  end

  def initialize params={}
    super
  	self.body ||= "
A wikilink can be created using [[match title]]

h3. Setup Steps

<enter all set up steps undertaken>

h3.  Testing Context

Explore ...
With ...
So that ...

h3. Test Strategies

<mind map of thoughts to help with exploratory testing>"
  
  end

  def set_content content
    self.contents.build body: content
  end

  def self.page_url_with_title search

  	if search
  		found = find(:all, :conditions => ['LOWER(title) = ?', "#{search}".downcase]).first
  	end
    
		host = Rails.application.config.action_mailer.default_url_options[:host]

    found ? "<a href=\"http://#{host}/pages/#{found.id}\">#{search}</a>" : '[[' + search + ']]'

  end

  def self.wiki_tags_to_urls s
  	pattern = Regexp.new(/\[\[([^"\r\n]*?)\]\]/)
    s = s.gsub(pattern) {|match| page_url_with_title($1) }
    return s
  end

  def self.urls2links s
	  s = s.gsub(/([^:])((https?|ftp)\:\/\/[^\s)'"]+[^.,)\s])(. |, |[\s]|\) | )/, '\1<a href="\2" target="_blank">\2</a>\4')
  	return s
	end

	def self.textile2html s
	  textilize( wiki_tags_to_urls(s) ).html_safe
	end

  def self.search search
    if search
      self.joins(:contents).select("DISTINCT(pages.id), pages.*").where("pages.title LIKE ? OR contents.body LIKE ?","%#{search}%","%#{search}%").order("created_at DESC")
    else
      #find(:all)
      self.select("pages.*").order("created_at DESC")
    end
  end

  def set_version revision
    content = self.revision_history(revision, 1)
  end
 

end
