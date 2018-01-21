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
                },

                crypto: {
                    name: JSON.parse(this.cryptoCurrency).name,
                    symbol: JSON.parse(this.cryptoCurrency).symbol,
                    price: 0
                }
            }
        },

        watch: {
            priceHolding: function() {
                this.notifyPrice();
            },

            'folio.holding': function(newHolding, oldHolding) {
            }
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
            },

            holding: function() {
                // Call backend
            }
        },

        methods: {
            updatePrice: function() {
                axios
                .get('https://min-api.cryptocompare.com/data/price?fsym=' + this.crypto.symbol + '&tsyms=' + this.currency.code)
                .then(function(response) {

                    this.crypto.price = response.data[this.currency.code];

                    setTimeout(function() {
                        this.updatePrice();
                    }.bind(this), 3000);

                }.bind(this));
            },

            notifyPrice: function() {
                window.bus.$emit('currencyUpdated', {
                    price: this.priceHolding,
                    symbol: this.crypto.symbol,
                    currency: this.currency.symbol
                });
            }
        }
    });

}());
