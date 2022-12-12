module UsersHelper
  def profile_image(user)
    gravatar_id = user.gravatar_id
    url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(url, alt: user.name)
  end
end
