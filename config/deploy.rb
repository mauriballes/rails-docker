# config valid only for current version of Capistrano
lock "3.9.0"

##### Need change to your own configs BEGIN: #####
server 'qubytesoft.net', roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:mauriballes/rails-docker.git'
set :application,     'rails-docker'
set :user,            'deploy'
##### Need change to your own configs END: #####

# Don't change these unless you know what you're doing
set :rbenv_ruby,      '2.3.1'
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  desc 'Testing Capistrano Tasks'
  task :testing_cap do
    on roles(:app) do
      puts "Testing Capistrano Tasks on #{current_path}"
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :testing_cap
end
