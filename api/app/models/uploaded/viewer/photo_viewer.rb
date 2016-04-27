# Contains basic methods to show photos
class Uploaded::Viewer::PhotoViewer
  # Converts attributes to hash
  # @param [Uploaded::Photo] photo
  # @return [Hash]
  def photo_to_hash(photo)
    {
      id: photo.id,
      url: ENV['UPLOAD_HOST'] + photo.file.url
    }
  end
end
