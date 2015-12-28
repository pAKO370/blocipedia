class Collaborator < ActiveRecord::Base

  belongs_to :wiki
  belongs_to :user

  validates_uniqueness_of :user, scope: [:wiki]

end
