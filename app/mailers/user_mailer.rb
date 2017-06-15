class UserMailer < ApplicationMailer
  def report_email(admin)
   @admin = admin
   @users= User.select{|u| u.Sbu == @admin.Sbu && u.onLeave != true }
   @timesheets= Timesheet.select{|t| t.Tdate== Date.today}
   @leftuser= @users.reject{|u| @timesheets.map{|t| t.user_id }.include? u.id }
   mail(to: @admin.email, subject: 'Timesheet Report')
 end
end
