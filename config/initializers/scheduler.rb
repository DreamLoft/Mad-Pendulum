require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton
#  recurrent task...
#s.every '2h' , :first_at => "#{Date.today} 15:35:00 +0530" do
s.every '24h' , :first_at => "#{Date.today} 23:05:00 +0530" do
  @admins= User.select{|u| u.isadmin== true}
  @admins.each do |admin|
    UserMailer.report_email(admin).deliver_now
  #UserMailer.report_email(user).set(wait: 1.minutes).deliver_now
  end
end
