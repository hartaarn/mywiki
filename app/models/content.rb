class Content < ActiveRecord::Base
  attr_accessible :title, :body, :created_by

  belongs_to :page

  def author
  end

end
