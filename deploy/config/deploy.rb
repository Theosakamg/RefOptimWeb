# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'Analytics'
set :repo_url, "git@github.com:Theosakamg/RefOptimWeb.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/analytics/"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{app/config/parameters.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{cache logs vendor web/exports}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

set :symfony_roles, :web
set :symfony_default_flags, '--quiet --no-interaction'
set :symfony_assets_flags, '--symlink'
set :symfony_cache_clear_flags, ''
set :symfony_cache_warmup_flags, ''
set :symfony_env, 'prod'

set :composer_install_flags, '--no-dev --no-interaction --optimize-autoloader'
set :composer_roles, :all
set :composer_dump_autoload_flags, '--optimize'
set :composer_download_url, "https://getcomposer.org/installer"
set :composer_version, '' #(default: not set)


SSHKit.config.command_map[:composer] = "composer"

namespace :deploy do


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :gemmyo do
  desc 'Force database update'
  task :database do
    on roles(:app) do
      invoke 'symfony:run', :'doctrine:schema:update', '--force'
    end
  end

  after 'deploy:updated', 'gemmyo:database'
end
