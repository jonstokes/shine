class RunSyncSession
  include Interactor::Organizer
  include Troupe

  organize MakeUpsertChanges, MakeDeleteChanges
end