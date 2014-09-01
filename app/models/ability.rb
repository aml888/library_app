class Ability
  include CanCan::Ability
  
  def initialize(user)
	alias_action :update, :destroy, to: :modify
	user ||= User.new
	
	can :manage, :all if user.admin?
	can [:read, :create], Book
	can :modify, Book, user_id: user.id

	
  end
  
end
