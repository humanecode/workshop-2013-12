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

  def posts_for group, date
    group.posts_for date
  end

  def post_for group, user, date
    group.post_for user, date
  end

  def add_post group, user, date, body
    group.add_post user, date, body
  end

  def comments_for post
    post.comments
  end

  def add_comment post, user, body
    post.comments.create user: user, body: body
  end
end
