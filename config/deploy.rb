require "bundler/capistrano"
require "rvm/capistrano"

set :application, "french-house"
set :repository,  "git://github.com/alexmuller/french-house.git"
set :scm, :git

server "lighfe.mullr.net", :app, :web, :db, :primary => true

set :user, "alexmuller"
set :deploy_to, "/srv/#{application}"
set :rvm_ruby_string, "1.9.3"

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Restart passenger by touching a file."
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink sensitive config files into the release."
  task :symlink_config do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end

before "deploy:assets:precompile", "deploy:symlink_config"

after "deploy:restart", "deploy:cleanup"
