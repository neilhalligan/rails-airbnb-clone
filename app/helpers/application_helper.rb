module ApplicationHelper
  def avatar_url
    if user_signed_in? && current_user.facebook_picture_url
      current_user.facebook_picture_url
    else
      "http://placehold.it/30x30"
    end
  end
end
