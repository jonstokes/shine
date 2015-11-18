namespace :contentful do
  desc "Initial sync of contenful"
  task :initial_sync do
    RunSyncSession.call(initial: true)
  end

  desc "Sync of contenful"
  task :sync do
    RunSyncSession.call
  end
end