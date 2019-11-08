module ApplicationHelper
  def error_messages_for(object)
    render('error_messages_for', msgs: object.errors.full_messages)
  end
end
