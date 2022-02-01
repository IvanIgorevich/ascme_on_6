import Rails from "@rails/ujs"
Rails.start()

import '../styles/application.scss'
const images = require.context('../images', true)

import 'bootstrap/dist/js/bootstrap'

$(function(){
  $('#ask-button').click(function(){
    $('#ask-form').slideToggle(300);
    return false;
  });
});
