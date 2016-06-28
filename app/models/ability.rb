class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Devx::User.new

    if user.super_administrator?
      can :manage, :all
    end

    if user.administrator?
      can :manage, Devx::User
      can :manage, Devx::Member
      can :manage, Devx::Sport
      can :manage, Devx::Extracurricular
      can :manage, Devx::Page
      can :manage, Devx::Layout
      can :manage, Devx::Stylesheet
      can :manage, Devx::Javascript
      can :manage, Devx::Medium
      can :manage, Devx::Menu
      can :manage, Devx::Calendar
      can :manage, Devx::Event
      can :manage, Devx::Venue
      can :manage, Devx::Article
      can :manage, Devx::Branding

      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['alumni_database']
        can :manage, Devx::Alumni
      end

      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['commerce']
        can :manage, Devx::Product
        can :manage, Devx::Order
      end

      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['registrations']
        can :manage, Devx::Registration
        can :manage, Devx::Form
      end
    end

    can :read, Devx::Dashboard
    can :read, Devx::Article
    can [:edit, :update], Devx::User, id: user.id
    can [ :read, :update ], Devx::Order, user_id: user.id
    can :create, Devx::Transaction

    can [ :read, :create ], Devx::Ticket, user_id: user.id
    can [ :read, :create ], Devx::TicketUpdate, user_id: user.id
  end
end