class CollaboratorPolicy < ApplicationPolicy
  attr_reader :current_user, :collaborator

  def initialize(current_user, wiki)
    @current_user = current_user
    @collaborator = collaborator
  end

  def index?
    
  end



  def edit?
    
  end

  def create?
    current_user.admin? || current_user.premium?
  end

  def destroy?

    current_user.admin? || current_user.premium?
    end
end
