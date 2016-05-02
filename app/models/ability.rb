class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Devx::User.new

    can :manage, :all
  end
end
