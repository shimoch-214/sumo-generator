# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

# Capistranoのログの表示に利用する
set :application, 'sumo-generator'

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
}

# set enviroment
set :rails_env, "production"
set :unicorn_rack_env, "production"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'https://github.com/shimoch-214/sumo-generator.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
# set :branch, 'automatic-deploy'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
# set :linked_files, %w{ config/master.key }
set :linked_files, fetch(:linked_files, []).push('config/master.key')
set :rbenv_type, :user
set :rbenv_ruby, '2.6.3' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/shimo_chat.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload master.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "sudo mkdir -p #{shared_path}/config"
      end
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end

  desc 'npm run build'
  after 'deploy:updated', :build do
    on roles :all do
      within current_path do
        execute :npm, 'install'
        execute :npm, 'run', 'build'
      end
    end
  end


  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
  
end

