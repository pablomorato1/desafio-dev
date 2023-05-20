class ImporterService
  attr_reader :read_file, :open_file

  def initialize(file)
    @open_file = File.open(file)
    @read_file = @open_file&.readlines
  end

  def import_and_create_data
    return false unless valid_extension?(@open_file)

    unsuccessful_lines = []

    @read_file.each do |line|
      data = convert_line_to_hash(line)
      provider = find_or_create(Provider, data['provider'], { name_provider: data['provider'][:name_provider].downcase })
      customer = find_or_create(Customer, data['customer'], { cpf: data['customer'][:cpf] })
      data_transaction = data['transaction'].merge({ customer: customer, provider: provider })

      begin
        Transaction.create!(data_transaction)
      rescue StandardError => e
        unsuccessful_lines << { line: line, errors: e.message }
        Rails.logger.error("Error creating transaction: #{e.message}")
      end
    end

    unsuccessful_lines
  end


  private

  def valid_extension?(file)
    %w[.txt .csv].include?(File.extname(file))
  end

  def find_or_create(klass, attributes, conditions)
    klass.find_or_create_by(conditions) do |obj|
      obj.assign_attributes(attributes)
    end
  end

  def convert_line_to_hash(line)
    {
      'transaction' => {
        transaction_type: (line[0, 1].strip.to_i - 1),
        date_register: Date.parse(line[1, 8].strip).strftime('%d/%m/%Y'),
        value: line[9, 10].strip.to_f / 100,
        hour_transaction: line[42, 6].strip.scan(/[0-9]{2}/).join(':'),
        card_number: line[30, 12].strip
      },
      'customer' => { cpf: line[19, 11].strip },
      'provider' => {
        name_owner: line[48, 14].strip,
        name_provider: line[62, 19].strip
      }
    }
  end
end
