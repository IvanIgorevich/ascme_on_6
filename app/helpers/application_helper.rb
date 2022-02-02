module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/avatar.jpg')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def inclination(number)
    return  'ов' if (11..14).include?(number % 100)

    last_digit = number % 10

    return  '' if last_digit == 1

    return  'а' if (2..4).include?(last_digit)

    'ов'
  end
end
