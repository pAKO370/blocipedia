class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  before_create :set_to_false

  scope :visible_to, -> (user) do
    if user.admin?
      all
    elsif user.premium?
      where("private = 'f' OR user_id = ?", user.id)
    else
      where(private: false)
    end
  end
  scope :visible_to_private, -> { where(private: true) }

  def title=(s)
    write_attribute(:title, s.to_s.capitalize)
  end

  def set_to_false
    if self.private == nil 
     self.private = "false"
    end
  
  end



end
