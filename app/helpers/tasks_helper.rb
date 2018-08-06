module TasksHelper
  def status_select_options
    Task.statuses.keys.map { |k| [t("enums.task.status.#{k}"), k] }
  end

  def priority_select_options
    Task.priorities.keys.map { |k| [t("enums.task.priority.#{k}"), k] }
  end
end
