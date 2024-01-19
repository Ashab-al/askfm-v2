class QuestionPolicy < ApplicationPolicy
  class Scope < Scope 
    def resolve
      return scope.all if user.present?

      scope.where(author: current_user)
    end
  end

  def initialize(question, current_user)
    @question = question
    @current_user = current_user
  end
  
  def show?
    false
  end

  def create?
    true
  end

  def update?
    @question.user == @current_user || @question.author == @current_user
  end

  def destroy?
    @question&.user == @current_user || @question&.author == @current_user  
  end

  def questions_by_tag?
    true
  end

end
