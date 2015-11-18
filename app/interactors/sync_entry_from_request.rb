class SyncEntryFromRequest
  include Troupe

  expects :params

  def call
    if record = klass.find_by(cid: attrs[:cid])
      record.update(attrs)
    else
      record = klass.create(attrs)
    end

    context.fail!(error: record.errors) unless record.valid?
  end

  def attrs
    @attrs ||= begin
      mapper = "#{klass.name}::RequestMapper".constantize.new(params)
      mapper.to_hash
    end
  end

  def klass
    @klass ||= Content.cid_to_class_name(params['sys']['contentType']['sys']['id']).constantize
  end
end