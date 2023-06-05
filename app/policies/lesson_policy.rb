class LessonPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def edit?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def new?
    user == record.course.user
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
