class Page < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :body

  belongs_to :user, foreign_key: :created_by
  has_many :contents
  has_many :tags, through: :tag_mappings

  validates :title, presence: true

  after_initialize :init

  def current_body
    contents.order('created_at  desc').limit(1).first.body
  end

  def init
  	self.body ||= "
h2. Setup Steps

<enter some steps required to do this>


h2. Test Strategies

<thoughts completed to get this done>"
  
  end

end
