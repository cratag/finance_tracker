class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    begin
      data = BasicYahooFinance::Query.new(ticker_symbol)
      data.quotes(ticker_symbol)[ticker_symbol]['regularMarketPrice']
    rescue => exception
      nil
    end
  end
end
