class InquiryMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']   # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :bcc => ENV['SEND_MAIL'], :subject => 'お問い合わせを承りました')
  end
end