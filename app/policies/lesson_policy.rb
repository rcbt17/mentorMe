class LessonPolicy < ApplicationPolicy
  def index?
    true
    scope.all
  end

  def show?
    record.user == user
  end

  def create?
    record.user == user
  end

  def edit?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def new?
    record.user == user
  end


class Scope < Scope
    def resolve
      scope.all
    end
  end
end
