document.addEventListener('turbolinks:load', function() {
  var timer = document.querySelector('.timer');
  
  function countdown () {
    var count = document.getElementById('counter')
    var limit = timer.dataset.restOfTheTime;
    var link = document.getElementById('result-page-link').href
    setInterval(function() {
      if (limit >= 0) { 
        count.innerHTML = limit;
        limit--;
      } else {
        document.location = link;
      };
    }, 1000);
  };
  
  if (timer) {
    countdown ();
  };
});