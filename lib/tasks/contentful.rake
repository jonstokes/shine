namespace :contentful do
  desc "Initial sync of contenful"
  task initial_sync: :environment do
    SyncSession.delete_all
    Author.delete_all
    Post.delete_all
    Category.delete_all
    Asset.delete_all
    RunSyncSession.call(mode: "all")
    RunSyncSession.call(mode: "deletion")
  end

  desc "Sync of contenful"
  task sync: :environment do
    RunSyncSession.call(mode: "all")
  end
end