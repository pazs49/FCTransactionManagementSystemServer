class Api::V1::TransactionsController < ApplicationController
  STATUSES = [ "Pending", "Settled", "Failed" ]

  def index
    transactions = TransactionCsvService.all
    render json: transactions
  end

  def create
    transaction_params = params.require(:transaction).permit(:transaction_date, :account_number, :account_holder_name, :amount)
    transaction = transaction_params.to_h.symbolize_keys.merge(status: STATUSES.sample)
    TransactionCsvService.add(transaction)
    render json: { message: "Transaction added successfully", transaction: transaction }, status: :created
  end
end
