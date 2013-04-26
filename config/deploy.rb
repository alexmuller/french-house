set :application, "french-house"
set :repository,  "git://github.com/alexmuller/french-house.git"
set :scm, :git

server "lighfe.mullr.net", :app, :web, :db, :primary => true

set :user, "alexmuller"
set :deploy_to, "/srv/#{application}"

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy" do
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
