module ApplicationHelper
  def avatar_url
    if user_signed_in? && current_user.facebook_picture_url
      current_user.facebook_picture_url
    else
      "https://wiki.cam.ac.uk/wiki/ajmorris/img_auth.php/4/41/Unknown_user.png"
    end
  end
end
