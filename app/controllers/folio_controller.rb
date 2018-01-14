class FolioController < ApplicationController

  def show
    %w(BTC ETH STR XRP).each do |symbol|
      #Folio::AddCryptoCurrency.(user_token: user['model'].token, symbol: symbol)
    end

  end
end
