# app/services/download_csv_service.rb
require 'csv'
require 'fileutils'

class DownloadCsvService
  CSV_HEADERS = ['ID', 'Name', 'Short Name', 'Location', 'City', 'State'].freeze

  def call
    local_file_path = generate_csv
    file_link = upload_to_google_drive(local_file_path)
    send_email(file_link)
  ensure
    File.delete(local_file_path) if local_file_path && File.exist?(local_file_path)
  end

  private

  def generate_csv
    file_path = Rails.root.join('tmp', "schools_#{Time.now}.csv")

    CSV.open(file_path, 'w', write_headers: true, headers: CSV_HEADERS) do |csv|
      School.all.each do |school|
        csv << [school.id, school.name, school.short_name, school.location, school.city, school.state]
      end
    end

    file_path.to_s
  end

  def upload_to_google_drive(local_file_path)
    UploadToGoogleDriveService.new(
      local_file_path,
      Rails.application.credentials.dig(:google_drive, :schools_export_drive_folder)
    ).upload!
  end

  def send_email(file_link)
    UserMailer.csv_export_complete(file_link).deliver_now
  end
end
