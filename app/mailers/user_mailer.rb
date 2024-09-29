class UserMailer < ApplicationMailer
  def csv_export_complete(file_link)
    @file_link = file_link
    mail(to: 'user@gmail.com', subject: 'Your CSV Export is Ready')
  end
end
