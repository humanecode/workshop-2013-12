class Standup
  def groups
    Group.all
  end

  def users_for group
    group.users
  end

  def is_member_of? group, user
    group.is_member? user
  end

  def add_user_to group, user
    group.add_member user
  end

  def remove_user_from group, user
    group.remove_member user
  end
end
