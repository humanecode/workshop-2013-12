module PermissionsHelper
  def can_create_post?
    return false if current_user.blank?
    if @group.present? && @day.present? &&
        Standup.new.is_member_of?(@group, current_user)
      post_on_day = Standup.new.post_for @group, current_user, @day
      return post_on_day.blank?
    end
    return false
  end

  def can_update_post?
    false
  end
  def can_create_comment?
    current_user.present?
  end

end
