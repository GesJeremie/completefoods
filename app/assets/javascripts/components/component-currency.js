(function()  {
    'use strict';

    Vue.component('component-currency', {
        props: ['cryptoCurrency', 'folioCryptoCurrency', 'folioCurrency'],

        data: function() {
            return {
                currency: {
                    code: JSON.parse(this.folioCurrency).code,
                    symbol: JSON.parse(this.folioCurrency).symbol
                },

                folio: {
                    holding: JSON.parse(this.folioCryptoCurrency).holding,

                    // TODO: Rename, this is ugly
                    cryptoCurrencyId: JSON.parse(this.folioCryptoCurrency).id
                },

                crypto: {
                    name: JSON.parse(this.cryptoCurrency).name,
                    symbol: JSON.parse(this.cryptoCurrency).symbol,
                    price: 0
                }
            }
        },

        watch: {
            'priceHolding': function() {
                this.notifyPrice();
            },

            'folio.holding': _.debounce(function(newHolding, oldHolding) {
                var token = this.getCsrfToken(),
                    request = '/folio_crypto_currency/' + this.folio.cryptoCurrencyId + '.json';

                axios
                .patch(request, {holding: newHolding, authenticity_token: token}, {responseType: 'json'})
                .then(this.onHoldingPersisted.bind(this));
            }, 500)
        },

        created: function() {
            this.updatePrice();
        },

        computed: {
            unitCryptoPrice: function() {
                return this.crypto.price;
            },

            priceHolding: function() {
                return (this.crypto.price * this.folio.holding);
            }
        },

        methods: {

            onUpdatedPrice: function(response) {
                this.crypto.price = response.data[this.currency.code];

                setTimeout(function() {
                    this.updatePrice();
                }.bind(this), 3000);
            },

            onHoldingPersisted: function(response) {
                var type, message;

                if (response.status === 200) {
                    message = this.crypto.name + ' udpated';
                    type = 'success';
                } else {
                    message = 'Impossible to update ' + this.crypto.name;
                    type = 'error';
                }

                this.showNotification(type, message);
            },

            updatePrice: function() {
                axios
                .get('https://min-api.cryptocompare.com/data/price?fsym=' + this.crypto.symbol + '&tsyms=' + this.currency.code)
                .then(this.onUpdatedPrice.bind(this));
            },

            notifyPrice: function() {
                window.bus.$emit('currencyUpdated', {
                    price: this.priceHolding,
                    symbol: this.crypto.symbol,
                    currency: this.currency.symbol
                });
            },

            // TODO: Could be a mixin since we gonna use for different XHR requests
            getCsrfToken: function() {
                return document.querySelector('[name="csrf-token"]').getAttribute('content');
            },

            // TODO: Could be a mixin to avoid duplication with component-flashes
            showNotification: function(type, message)  {
                new Noty({
                    type: type,
                    text: message,
                    timeout: 1000,
                    theme: 'custom'
                }).show();
            }
        }
    });

}());
