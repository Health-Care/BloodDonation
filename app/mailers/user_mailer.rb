class UserMailer < ActionMailer::Base
  default from: "ibrahim.ali.0403@gmail.com"

  def new_request_email(user, request)
    @user = user
    @request_url = request_url(request)
    mail(to: "ibrahim@faselty.me", subject: 'Donation Chance!')
  end


  def new_reply_email(user, request)
    @request = request
    @user = user
    @user_url = user_url(@user)
    mail(to: @request.email, subject: 'Donor Comming!')
  end

end
