def load_request(type:, action:)
  filename = if type == "asset"
    "ContentManagement.Asset.#{action}.json"
  else
    "ContentManagement.Entry.#{action}.json"
  end
  JSON.load(Rails.root.join('spec', 'fixtures', 'requests', type, filename))
end

def load_sync(type)
  JSON.load(Rails.root.join('spec', 'fixtures', 'sync', "#{type}.json"))
end

def item_json(klass:, action:)
  if action == :publish
  end
end
