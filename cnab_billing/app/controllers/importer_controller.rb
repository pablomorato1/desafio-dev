class ImporterController < ApplicationController

  def import_file
    file = params[:imported_file]

    importer = ImporterService.new(file.path)
    unsuccessful_lines = importer.import_and_create_data

    if unsuccessful_lines.empty?
      flash[:success] = 'File imported successfully.'
      redirect_to root_path
    else
      flash[:error] = 'Error importing file. Some lines could not be processed.'
      render json: { unsuccessful_lines: unsuccessful_lines }, status: :unprocessable_entity
    end
  end
end
