module UsersHelper
  def profile_image(user, size=80)
    gravatar_id = user.gravatar_id
    url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name)
  end
end
