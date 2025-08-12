class TransactionsController < ApplicationController
  def index
    transactions = TransactionCsvService.all
    render json: transactions
  end

  def create
    transaction = {
      id: SecureRandom.uuid,
      description: params[:description],
      amount: params[:amount],
      date: params[:date]
    }

    TransactionCsvService.add(transaction)
    render json: { message: "Transaction added successfully", transaction: transaction }, status: :created
  end
end
