require "csv"

class TransactionCsvService
  FILE_PATH = Rails.root.join("storage", "transactions.csv")

  def self.all
    return [] unless File.exist?(FILE_PATH)

    CSV.read(FILE_PATH, headers: true).map(&:to_h)
  end

  def self.add(transaction)
    headers = %w[id description amount date]

    CSV.open(FILE_PATH, File.exist?(FILE_PATH) ? "ab" : "wb") do |csv|
      csv << headers unless File.exist?(FILE_PATH)
      csv << [ transaction[:id], transaction[:description], transaction[:amount], transaction[:date] ]
    end
  end
end
