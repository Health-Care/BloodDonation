class ContentsController < ApplicationController
  def index
   if user_signed_in?
      redirect_to user_path(current_user)
    end
  end

  def about
  end

  def donor_info
  end

  def donation_info
  end

  def blood_info
  end

  def patient_info
  end

  def news
  end

  def contact
  end

end
