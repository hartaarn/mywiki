class Page < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper
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

  def initialize params={}
    super
  	self.body ||= "
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

  def self.search_match_title_path search

  	if search
  		page_id = find(:all, :conditions => ['title = ?', "#{search}"]).first.id
  	end
    "pages/#{page_id}"
  end

  def self.search search
    if search
      self.joins(:contents).select("DISTINCT(pages.id), pages.*").where("pages.title LIKE ? OR contents.body LIKE ?","%#{search}%","%#{search}%").order("created_at DESC")
    else
      #find(:all)
      self.select("pages.*").order("created_at DESC")
    end
  end

  

end
