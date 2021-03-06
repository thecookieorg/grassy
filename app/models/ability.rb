class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
        can :manage, :all
    else
        can :read, Category
        cannot :index, Dashboard
        cannot :index, Product #I added 'authorize! :index' in my products_controller.rb so users can't access products index page, only admins.
        cannot :index, Slideshow
        cannot :index, Staticimage
        can :show, Product # This is to allow users to click on individual products show page, so they can add them to cart.
        can :show, StorePolicy
    end







    
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
