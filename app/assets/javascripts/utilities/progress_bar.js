document.addEventListener('turbolinks:load', function() {
  progress = document.querySelector('.progress');
  if (progress) { 
    var width = progress.dataset.percent;
    progress.style.width = width;
  };    
});
