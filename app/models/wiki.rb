class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
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
  #scope that displays only public wikis
  scope :visible_to_private, -> { where(private: false) }

  def title=(s) #capitalizes first letter of wiki title
    write_attribute(:title, s.to_s.capitalize)
  end

  def set_to_false # sets wiki.private to false when created
    if self.private == nil 
     self.private = "false"
    end
  
  end



end
