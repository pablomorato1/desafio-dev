class HomeController < ApplicationController

  def index
    @transactions = Transaction.all.includes(:customer, :provider)
  end
end
