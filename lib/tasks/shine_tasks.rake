namespace :shine do
  desc "Synchronizes with contentful.com"
  task sync_all: :environment do
    Shine::RunSyncSession.call
  end

  desc "Synchronizes with contentful.com"
  task sync_deletions: :environment do
    Shine::RunSyncSession.call(mode: "deletion")
  end
end