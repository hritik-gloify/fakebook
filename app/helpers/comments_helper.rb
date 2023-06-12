module CommentsHelper
  def authenticated_comment?(user)
    user == current_user.username
  end
end