require "rvm/capistrano"

set :application, "french-house"
set :repository,  "git://github.com/alexmuller/french-house.git"
set :scm, :git

server "lighfe.mullr.net", :app, :web, :db, :primary => true

set :user, "alexmuller"
set :deploy_to, "/srv/#{application}"
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :bundle do
  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    run "cd #{current_path} && bundle install  --without=test --no-update-sources"
  end
end

namespace :config do
  desc "symlink sensitive config files into the release"
  task :symlink do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

before "deploy:restart", "bundle:install"

after "deploy:restart", "deploy:cleanup"

after "deploy", "config:symlink"
