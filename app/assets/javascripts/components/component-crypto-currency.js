(function()  {
    'use strict';

    Vue.component('component-crypto-currency', {
        mixins: [
            window.mixins.notification
        ],

        props: [
            'propCryptoCurrency',
            'propFolioCryptoCurrency',
            'propFolioCurrency'
        ],

        data: function() {
            return {
                folioCurrency: {
                    code:      JSON.parse(this.propFolioCurrency).code,
                    symbol:    JSON.parse(this.propFolioCurrency).symbol,
                    id:        JSON.parse(this.propFolioCurrency).id
                },

                folioCryptoCurrency: {
                    id:        JSON.parse(this.propFolioCryptoCurrency).id,
                    holding:   JSON.parse(this.propFolioCryptoCurrency).holding
                },

                cryptoCurrency: {
                    id:                  JSON.parse(this.propCryptoCurrency).id,
                    name:                JSON.parse(this.propCryptoCurrency).name,
                    symbol:              JSON.parse(this.propCryptoCurrency).symbol,
                    media:               JSON.parse(this.propCryptoCurrency).media,
                    oldPrice:            0,
                    price:               0,
                    priceLow24Hours:     0,
                    priceHigh24Hours:    0
                },

                showClassPriceUp: false,
                showClassPriceDown: false
            }
        },

        watch: {
            'priceHolding': function() {
                this.notifyPrice();
            }
        },

        created: function() {
            window.bus.$on('cryptoSync:updated:' + this.cryptoCurrency.id, this.onCryptoSyncUpdated.bind(this));
        },

        computed: {
            priceHolding: function() {
                return (this.cryptoCurrency.price * this.folioCryptoCurrency.holding);
            },

            priceOldHolding: function() {
                return (this.cryptoCurrency.oldPrice * this.folioCryptoCurrency.holding);
            },

            priceHoldingLow24Hours: function() {
                return (this.cryptoCurrency.priceLow24Hours * this.folioCryptoCurrency.holding);
            },

            priceHoldingHigh24Hours: function() {
                return (this.cryptoCurrency.priceHigh24Hours * this.folioCryptoCurrency.holding);
            },

            isPriceUp: function() {
                return this.priceHolding > this.priceOldHolding;
            },

            isPriceDown: function() {
                return this.priceHolding < this.priceOldHolding;
            },

            media: function() {
                return 'https://www.cryptocompare.com' + this.cryptoCurrency.media;
            }
         },

        methods: {

            onChangeHolding: function(e) {
                this.folioCryptoCurrency.holding = Math.abs(this.folioCryptoCurrency.holding);
                this.persistHolding();
            },

            onCryptoSyncUpdated: function(response) {
                this.showClassPriceDown = false;
                this.showClassPriceUp = false;

                this.cryptoCurrency.oldPrice = this.cryptoCurrency.price;
                this.cryptoCurrency.price = response.data.price;
                this.cryptoCurrency.priceLow24Hours = response.data.price_low_24_hours;
                this.cryptoCurrency.priceHigh24Hours = response.data.price_high_24_hours;

                if (this.isPriceDown) {
                    this.showClassPriceDown = true;
                }

                if (this.isPriceUp) {
                    this.showClassPriceUp = true;
                }

                this.notifyPrice();

            },

            onHoldingPersisted: function(response) {
                var type, message;

                if (response.status === 200) {
                    message = this.cryptoCurrency.name + ' udpated';
                    type = 'success';
                } else {
                    message = 'Impossible to update ' + this.cryptoCurrency.name;
                    type = 'error';
                }

                this.$notification.show(type, message);
            },

            persistHolding: _.debounce(function() {
                var token = this.getCsrfToken(),
                    request = '/folio_crypto_currency/' + this.folioCryptoCurrency.id + '.json';

                axios
                .patch(request, {holding: this.folioCryptoCurrency.holding, authenticity_token: token}, {responseType: 'json'})
                .then(this.onHoldingPersisted.bind(this));
            }, 500),

            notifyPrice: function() {
                window.bus.$emit('cryptoCurrencyUpdated', {
                    price: this.priceHolding,
                    symbol: this.cryptoCurrency.symbol,
                });
            },

            // TODO: Could be a mixin since we gonna use for different XHR requests
            getCsrfToken: function() {
                return document.querySelector('[name="csrf-token"]').getAttribute('content');
            }
        }
    });

}());
