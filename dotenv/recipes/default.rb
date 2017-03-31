node[:deploy].each do |application, deploy|
  template "#{deploy[:deploy_to]}/shared/.env" do
    source 'dotenv.erb'
    mode 0644
    owner deploy[:user]
    group deploy[:group]
    variables(
      :environment => OpsWorks::Escape.escape_double_quotes(deploy[:environment_variables])
    )
  end
end
