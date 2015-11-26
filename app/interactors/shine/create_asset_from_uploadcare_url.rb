module Shine
  class CreateAssetFromUploadcareUrl
    include Troupe

    expects :file_url, :user_id

    permits :title, :description, :post_id

    provides(:uploadcare_id) do
      file_url.split("/")[3]
    end

    provides(:file) do
      UPLOADCARE_SETTINGS.api.file(uploadcare_id)
    end

    provides(:asset)

    def call
      file.load_data!
      self.asset = Shine::Asset.where("file->>'id' = ?", file.uuid) ||
        Shine::Asset.create(
          user:        user,
          title:       title,
          description: description,
          post:        post,
          uploaded_at: file.datetime_uploaded
          file: {
            id:        file.uuid,
            mime_type: file.mime_type,
            name:      file.original_filename,
            source:    file.source
          }.merge(file.image_info)
        )
      context.fail! unless asset.valid?
    end
  end
end