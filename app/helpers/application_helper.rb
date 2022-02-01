module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/avatar.jpg')
  end

  def question_counter(questions)
    question_counter = questions.count
    "У Вас #{question_counter} #{inclination(question_counter)}"
  end

  private

  def inclination(number)
    return  'вопросов' if (11..14).include?(number % 100)

    last_digit = number % 10

    return  'вопрос' if last_digit == 1

    return  'вопроса' if (2..4).include?(last_digit)

    'вопросов'
  end
end
