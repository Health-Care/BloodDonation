class UserMailer < ActionMailer::Base
  default from: "faselty.team@gmail.com"

  def new_request_email(users, request, blood_type)
      @blood_type = blood_type
      @request_url = request_url(request)

      emails = users.collect(&:email).join("; ")
      mail(to: emails, subject: 'Donation Chance!')
  end


  def new_reply_email(user, request)
    @request = request
    @user = user
    @user_url = user_url(@user)
    mail(to: @request.contact_email, subject: 'Donor Comming!')
  end

end
