module TasksHelper
  def get_status_select_options
    Task.statuses.keys.map { |k| [t("enums.task.status.#{k}"), k] }
  end

  def get_priority_select_options
    Task.priorities.keys.map { |k| [t("enums.task.priority.#{k}"), k] }
  end
end
