// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require gmaps/google

function show_notification_system(msg){  

  $(document).ready(function() {  
    $.meow({ 
      message: msg, 
      icon: 'http://findicons.com/files/icons/1075/scrap/300/administrator_2.png'
    });
  });
}

 
function show_notification_blood(msg){  
  $(document).ready(function() {  
    $.meow({
      title: "عاجل",
      message: "فيه " + msg +" حالات عاوزين مساعدتك", 
      icon: 'http://static.wixstatic.com/media/9ba976_9ce0a72cba74472cb76112fd1376bf42.jpg'
    });
  });
}


