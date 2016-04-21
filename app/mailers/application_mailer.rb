class ApplicationMailer < ActionMailer::Base
  default from: 'shostikandrej@gmail.com',
          template_path: 'mailers'
end
