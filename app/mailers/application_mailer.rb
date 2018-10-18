class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <mail@testguru.com>}
  default to:  ENV['MAIN_ADMIN']
  layout 'mailer'  
end
