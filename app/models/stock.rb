class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      data = BasicYahooFinance::Query.new(ticker_symbol).quotes(ticker_symbol)[ticker_symbol]
      new(ticker: ticker_symbol, name: data['shortName'], last_price: data['regularMarketPrice'])
    rescue => exception
      nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
