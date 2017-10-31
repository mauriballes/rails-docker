namespace :deploy do
  desc 'List files on project'
  task :list do
    on roles(:app) do
      within "#{current_path}" do
        execute "cd #{current_path} && ls -la"
      end
    end
  end
end