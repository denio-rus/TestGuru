document.addEventListener('turbolinks:load', function() {
  var timer = document.querySelector('.timer');
  
  function countdown () {
    var count = document.getElementById('counter')
    var limit = timer.dataset.restOfTheTime;
    var form = document.getElementById('form_test_passage')
    setInterval(function() {
      if (limit >= 0) { 
        count.innerHTML = timeConverter(limit);
        limit--;
      } else {
        form.submit();
      };
    }, 1000);
    function timeConverter (seconds) {
      var sec = seconds % 60;
      var min = Math.floor(seconds / 60 % 60);
      var hour = Math.floor(seconds / 3600 % 24);
      return `${hour}:${min}:${sec}`;
    }
  };

  if (timer) {
    countdown ();
  };
});