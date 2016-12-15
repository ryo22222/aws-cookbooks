default[:play][:install_dir] = node[:play][:install_dir] || "/opt/www"
default[:play][:home] = "#{node[:play][:install_dir]}/play-#{node[:play][:version]}"
