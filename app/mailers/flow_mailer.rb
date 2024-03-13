# app/mailers/flow_mailer.rb
class FlowMailer < ApplicationMailer
    def flow_updated(flow)
      @flow = flow
      @user = User.find(@flow.assigned_user_id)
      mail(to: @user.email, subject: 'Flow Updated')
    end
  end
  