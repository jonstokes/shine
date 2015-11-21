namespace :shine do
  desc "Synchronizes with contentful.com"
  task sync_all: :environment do
    Shine::RunSyncSession.call
  end

  desc "Deletes local cache and syncs with contentful.com"
  task initial_sync: :environment do
    Shine::Post.delete_all
    Shine::Author.delete_all
    Shine::Asset.delete_all
    Shine::Category.delete_all
    Shine::RunSyncSession.call
  end

  desc "Synchronizes with contentful.com"
  task sync_deletions: :environment do
    Shine::RunSyncSession.call(mode: "deletion")
  end
end