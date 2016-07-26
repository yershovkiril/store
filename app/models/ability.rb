class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user && user.admin
      can :access, :rails_admin
      can :manage, :all
    else
      can :read, [Book, Category, Author, Review]
      can :manage, Order
      can :manage, OrderBook
      can :manage, User
      can :create, Review
      can :update, Review
    end
  end
end
