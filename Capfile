# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Adding Capistrano
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rbenv'

set :rbenv_custom_path, '/home/deploy/.rbenv' # put your server user, in my case: deploy
set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.1' # your ruby version on rbenv

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
