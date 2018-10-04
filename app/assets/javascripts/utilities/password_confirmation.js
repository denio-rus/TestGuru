document.addEventListener('turbolinks:load', function() {
  var confirmationControl  = document.querySelector('#user_password_confirmation')
  
  // if password will be entered after confirmation
  var passwordControl = document.querySelector('#user_password')

  if (confirmationControl) { confirmationControl.addEventListener('input', checkConfirmation) }
  if (passwordControl) {passwordControl.addEventListener('input', checkConfirmation) }
})

function checkConfirmation() {
  var password = document.querySelector("#user_password").value
  var confirmation = document.querySelector("#user_password_confirmation").value

  if (password !== confirmation && confirmation) {
    document.querySelector('.octicon-x').classList.remove('hide')
    document.querySelector('.octicon-verified').classList.add('hide')
  }

  if (password === confirmation && confirmation) {
    document.querySelector('.octicon-verified').classList.remove('hide')
    document.querySelector('.octicon-x').classList.add('hide')  
  }
}