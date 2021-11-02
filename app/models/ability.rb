class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user && user.admin
      can :access, :rails_admin
      can :manage, :all
    elsif user
      can :read, [Book, Category, Author, Review, CreditCard]
      can :manage, Order
      can :manage, OrderBook
      can :manage, User
      can :create, Review
      can :update, Review
      can :create, CreditCard
      can :update, CreditCard
    else
      can :read, [Book, Category, Author, Review, CreditCard]
      can :manage, Order
      can :manage, OrderBook
      can :create, CreditCard
      can :update, CreditCard
    end
  end
end
