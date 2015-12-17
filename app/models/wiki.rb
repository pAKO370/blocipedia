class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  def title=(s)
    write_attribute(:title, s.to_s.capitalize)
  end


end
