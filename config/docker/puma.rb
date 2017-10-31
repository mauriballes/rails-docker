#!/usr/bin/env puma

directory '/home/{user}/apps/{application}/current'
rackup "/home/{user}/apps/{application}/current/config.ru"
environment 'production'

tag ''

pidfile "/home/{user}/apps/{application}/shared/tmp/pids/puma.pid"
state_path "/home/{user}/apps/{application}/shared/tmp/pids/puma.state"
stdout_redirect '/home/{user}/apps/{application}current/log/puma.error.log', '/home/{user}/apps/{application}/current/log/puma.access.log', true


threads 4,16


# default host and port
bind 'tcp://127.0.0.1:3000'

workers 0





preload_app!


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/{user}/apps/{application}/current/Gemfile"
end


before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end