class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :tag

  has_many :pages, through: :tag_mappings

  validates :tag, presence: :true

  def self.find_or_create tag_name
    tag_name.downcase!

    tag = Tag.where(tag: tag_name).first

    return tag if tag.present?
    Tag.create(tag: tag_name)
  end  

end
