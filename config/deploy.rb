require "bundler/capistrano"

servers = ['78.46.179.40']
role :web, *servers
role :app, *servers

role :db,  servers.first, :primary => true

set :application, "dns.1stsite.ru"
set :user, "dns"
set :rails_env, "production"

set :deploy_to, "/home/#{user}/www/#{application}"
set :use_sudo, false
set :unicorn_conf, "/etc/unicorn/#{application}.rb"
set :unicorn_pid, "#{deploy_to}/shared/unicorn.pid"


set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git.
set :scm_user, :git
set :branch, "master"
set :repository,  "https://github.com/krivospitsky/powerdns-on-rails.git" # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить их в deployment keys в настройках репозитария.
set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.
set :keep_releases, 5

set :default_environment, { "PATH" => "/home/#{user}/.rbenv/bin:/home/#{user}/.rbenv/shims:$PATH" }

namespace :deploy do
  desc "Link configs from shared"
  task :link_config, :roles => [:web, :db, :app] do
    cmd = []
    %w(database.yml).each do |config|
      cmd << "ln -s #{deploy_to}/#{config} #{release_path}/config/#{config}"
    end
    run cmd.join(' && ')
  end


    after "deploy:finalize_update" do
#    after "deploy:update_code" do
    link_config
  end

  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end
