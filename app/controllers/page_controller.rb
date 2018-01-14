class PageController < ApplicationController

  def home
    op_user = User::CreateAnonymous.()
    op_folio = Folio::Create.(user_token: op_user['model'].token)

    %w(BTC ETH STR XRP XMR BCH ADA).each do |symbol|
      Folio::AddCryptoCurrency.(
        crypto_currency: symbol,
        folio_id: op_folio['model'].id
      )
    end

    @folio = op_folio['model']
  end
end
