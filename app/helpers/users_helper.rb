module UsersHelper
  def role_select_options
    User.roles.keys.map { |k| [t("enums.user.role.#{k}"), k] }
  end
end
