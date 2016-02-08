//  Copyright (c) 2008-2016, Puzzle ITC GmbH. This file is part of
//  Cryptopus and licensed under the Affero General Public License version 3 or later.
//  See the COPYING file at the top-level directory or at
//  https://github.com/puzzle/cryptopus.

$('.result-password .password-link').click(function(e) {
  e.preventDefault();
  var passLink = $(e.target),
    passInput = passLink.next('.password-hidden');

  passLink.hide();
  passInput.removeClass('hide');
  setTimeout(function(){
     passInput.select();
  }, 80);

  setTimeout(function(){
      passLink.show();
      passInput.addClass('hide');
  }, 5000);
});

$( document ).ready(function(){
  var ie10andbelow = navigator.userAgent.indexOf('MSIE') != -1 || /MSIE 10/i.test(navigator.userAgent) || /rv:11.0/i.test(navigator.userAgent);
  if(ie10andbelow){
    $('.clip_button_account').remove();
  }else{
    new ZeroClipboard( $('.clip_button_account') );
  }
});

