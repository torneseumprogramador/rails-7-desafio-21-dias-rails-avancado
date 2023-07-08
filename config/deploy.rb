# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "rails-desafio"
set :repo_url, "https://github.com/torneseumprogramador/rails-7-desafio-21-dias-rails-avancado.git"


# No seu script Capistrano
namespace :deploy do
  desc 'Executa o bundle install no ambiente do RVM'
  task :bundle_install do
    on roles(:app) do
      within release_path do
        execute "cd #{release_path} && ~/.rvm/bin/rvm 3.2.2 do bundle install"
        execute "cd #{release_path} && ~/.rvm/bin/rvm 3.2.2 do rake assets:precompile"
        execute "kill -9 $(lsof -t -i:3000) || true"
        execute "cd #{release_path} && ~/.rvm/bin/rvm 3.2.2 do nohup rails s -p 3000 -e production > /dev/null 2>&1 &"
      end
    end
  end
end

after 'deploy:updating', 'deploy:bundle_install'

  
set :branch, 'main'

  
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
