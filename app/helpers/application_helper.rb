module ApplicationHelper
  def avatar_url
    if current_user
      current_user.facebook_picture_url
    else
      "http://placehold.it/30x30"
    end
  end
end
