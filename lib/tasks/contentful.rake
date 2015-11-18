namespace :contentful do
  desc "Initial sync of contenful"
  task initial_sync: :environment do
    SyncSession.delete_all
    RunSyncSession.call(initial: true)
  end

  desc "Sync of contenful"
  task sync: :environment do
    RunSyncSession.call
  end
end