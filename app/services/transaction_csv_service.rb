require "csv"

class TransactionCsvService
  FILE_PATH = Rails.root.join("storage", "transactions.csv")

  def self.all
    return [] unless File.exist?(FILE_PATH)
    CSV.read(FILE_PATH, headers: true).map(&:to_h)
  end

  def self.add(transaction)
    headers = [
      "Transaction Date",
      "Account Number",
      "Account Holder Name",
      "Amount",
      "Status"
    ]

    file_exists = File.exist?(FILE_PATH)

    CSV.open(FILE_PATH, file_exists ? "ab" : "wb") do |csv|
      csv << headers unless file_exists
      csv << [
        transaction[:transaction_date],
        transaction[:account_number],
        transaction[:account_holder_name],
        transaction[:amount],
        transaction[:status]
      ]
    end
  end
end
