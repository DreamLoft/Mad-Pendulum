class ReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # @users= User.select{|u| u.isadmin== true}
    #
    # @users.each |user| do
    # UserMailer.report_email(user).set(wait: 1.minutes).deliver_now
    # end
    #@user = User.find_by(email: "sharma26sh@yahoo.in")

  end
end
