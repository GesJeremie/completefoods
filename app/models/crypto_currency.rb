class CryptoCurrency < ApplicationRecord

  def self.not_added_by_user(user)
    ids_added = user.folio_crypto_currencies.pluck(:crypto_currency_id)
    where.not(id: ids_added)
  end

end
