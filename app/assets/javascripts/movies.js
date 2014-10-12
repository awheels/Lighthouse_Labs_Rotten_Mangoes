$(document).ready(function(){
    function fixDiv() {
      var $cache = $('#fixed-box'); 
      if ($(window).scrollTop() > 70) 
        $cache.css({'position': 'fixed', 'top': '7px'}); 
      else
        $cache.css({'position': 'absolute', 'top': '77px'});
    }
    $(window).scroll(fixDiv);
    fixDiv();
});
