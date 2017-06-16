class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user ||= User.new 
        can :read, :all
    end
    
    if user.admin?
        can :manage, :all
    else
        can :read, :all
        can [:read, :create], Question
        can [:update, :destroy], Question, :user_id => user.id
        can [:read, :create], Answer
        can [:update, :destroy], Answer, :user_id => user.id
        can [:read, :create], Message
        can [:update, :destroy], Message, :user_id => user.id
        can [:read, :create], Reply
        can [:update, :destroy], Reply, :user_id => user.id
        can [:read, :create], ReplyAnswer
        can [:update, :destroy], ReplyAnswer, :user_id => user.id
        can [:read, :create], Comment
        can [:update, :destroy], Comment, :user_id => user.id
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
