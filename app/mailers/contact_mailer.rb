class ContactMailer < ApplicationMailer
  default from: "non-reply@arm-contact.com"
  def contact_email(fromemail, toemail, name, phone, comment)
    @fromemail = fromemail
    @toemail = toemail
    @name = name
    @phone = phone
    @comment = comment
    mail(to: @toemail, subject: "#{@name} se ha puesto en contacto con ARM")
  end
end
