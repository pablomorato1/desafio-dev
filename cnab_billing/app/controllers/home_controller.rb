class HomeController < ApplicationController

  def index
    @providers = Provider.all.includes(transactions: :customer).with_transaction_values
  end
end
