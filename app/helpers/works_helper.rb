module WorksHelper
  def work_status_color(status)
    case status.to_sym
    when :pending
      'warning'
    when :in_progress
      'info'
    when :finished
      'success'
    when :cancelled
      'danger'
    else
      'secondary'
    end
  end
end 