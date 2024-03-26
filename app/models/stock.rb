class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: ENV["IEX_API_KEY"],
            endpoint: 'https://cloud.iexapis.com/v1'
        )

        begin
            company = client.company(ticker_symbol)
            new(ticker: ticker_symbol, name: company.company_name, last_price: client.price(ticker_symbol))
        rescue => exception 
            return nil
        end

    end
end
