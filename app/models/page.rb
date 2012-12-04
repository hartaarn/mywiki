class Page < ActiveRecord::Base
  attr_accessible :title, :current_body
  attr_accessor :body, :title

  belongs_to :user, foreign_key: :created_by
  has_many :contents
  has_many :tags, through: :tag_mappings

  validates :title, presence: true

  #after_initialize :init

  def current_body
    contents.order('created_at  desc').limit(1).first.body
  end

  def initialize params={}
    super
  	self.body ||= "
h3. Setup Steps

<enter some steps required to do this>


h3. Test Strategies

<thoughts completed to get this done>"
  
  end

  def set_content content
    self.contents.build body: content
  end

end
