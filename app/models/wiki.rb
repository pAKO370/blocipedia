class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  before_create :set_to_false

  scope :visible_to, -> { where(private: false) }

  def title=(s)
    write_attribute(:title, s.to_s.capitalize)
  end
  def set_to_false
    if self.private == nil 
       self.private = "false"
  end
  
  end



end
