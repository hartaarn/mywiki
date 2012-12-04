class Ability
  include CanCan::Ability

   def initialize(user)
    user ||= User.new # guest user
 
    if user.role? :Admin
      can :manage, :all
      can :publish, Page
    elsif user.role? :Member
      can :read, :all
      can :create, [Page, Tag]
      can [:edit, :update], [Page, Tag]
    end
  end

end