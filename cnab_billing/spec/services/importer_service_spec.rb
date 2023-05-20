require 'rails_helper'

RSpec.describe ImporterService do
  describe '#import_and_create_data' do
    let(:file_path) { "#{Rails.root}/vendor/CNAB.txt" }
    let(:service) { ImporterService.new(file_path) }

    context 'with a valid file' do
      it 'imports and creates data successfully' do
        expect(service.import_and_create_data).to be_empty
      end
    end

    context 'with an invalid file' do
      let(:file_path) { "#{Rails.root}/vendor/CNAB_invalid.txt" }

      it 'returns unsuccessful lines' do
        unsuccessful_lines = service.import_and_create_data
        expect(unsuccessful_lines).not_to be_empty
      end
    end
  end
end
