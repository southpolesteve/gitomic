class UserMailer < ActionMailer::Base
  
  def invite(invter, invitee)
    @inviter = inviter
    @invitee = invitee

    mail  to: invitee,
          subject: 'Invite!'
  end

end
