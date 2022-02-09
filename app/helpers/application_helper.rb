module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/avatar.jpg')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def inclination(number, word1, word2, word5)
    return  word5 if (11..14).include?(number % 100)

    last_digit = number % 10

    return  word1 if last_digit == 1

    return  word2 if (2..4).include?(last_digit)

    word5
  end
end
