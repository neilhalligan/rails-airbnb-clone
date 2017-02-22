module ApplicationHelper
  def avatar_url
    if user_signed_in? && current_user.facebook_picture_url
      current_user.facebook_picture_url
    else
      "https://s.aolcdn.com/hss/storage/midas/627f1d890718ff2c58318a280145a153/203216448/nicholas-cage-con-air.jpg"
    end
  end
end
