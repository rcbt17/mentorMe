class ReviewPolicy < ApplicationPolicy
  def create?
    CourseSubscription.user_subscribed?(user, record.course)
  end
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
