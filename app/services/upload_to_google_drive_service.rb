require 'google_drive'

class UploadToGoogleDriveService
  def initialize(file_path, folder_id)
    @file_path = file_path
    @folder_id = folder_id
  end

  def upload!
    session = GoogleDrive::Session.from_config('service_account.json')
    folder = session.collection_by_id(@folder_id)

    raise 'Folder not found in shared drive' if folder.nil?

    file = folder.upload_from_file(@file_path)
    file.human_url
  end
end
