class Page < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, foreign_key: :created_by
  has_many :contents
  has_many :tags, through: :tag_mappings
end
