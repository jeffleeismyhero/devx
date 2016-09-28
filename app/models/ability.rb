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
      can :manage, Devx::Schedule
      can :manage, Devx::Venue
      can :manage, Devx::Article
      can :manage, Devx::Document
      can :manage, Devx::Person
      can :manage, Devx::Announcement
      can :manage, Devx::Form
      can :manage, Devx::Field
      can :manage, Devx::FormSubmission
      can :manage, Devx::UrgentNews
      can :manage, Devx::Slideshow
      can :manage, Devx::Slide

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

    if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['balance_tracking']
      if user.balance_manager?
        can :manage, Devx::AccountTransaction
        can :manage, Devx::Person
      end
    end

    if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['classroom_profiles'] && user.faculty?
      can [ :read, :edit, :update ], Devx::Classroom, :classroom_teachers => { person_id: user.person.id }
      can :manage, Devx::ClassAnnouncement, classroom_id: user.person.try(:classroom_id)
      can :manage, Devx::ClassDocument, classroom_id: user.person.try(:classroom_id)
      can :manage, Devx::ClassGallery, classroom_id: user.person.try(:classroom_id)
      can :manage, Devx::ClassHighlight, classroom_id: user.person.try(:classroom_id)
      can :manage, Devx::ClassSchedule, classroom_id: user.person.try(:classroom_id), :classroom => { :classroom_teachers => { person_id: user.person.id } }
      can :manage, Devx::ClassPhoto, classroom_id: user.person.try(:classroom_id)
    end

    can :read, Devx::Dashboard
    can :read, Devx::Article
    can :read, Devx::Classroom
    can [:read, :edit, :update, :account_balance, :end_impersonation], Devx::User, id: user.id
    can [ :read, :update ], Devx::Order, user_id: user.id
    can :create, Devx::Transaction
    can [ :read, :create ], Devx::AccountTransaction
    can [ :donate ], Devx::Donation

    can [ :read, :create ], Devx::Ticket, user_id: user.id
    can [ :read, :create ], Devx::TicketUpdate, user_id: user.id
  end
end
