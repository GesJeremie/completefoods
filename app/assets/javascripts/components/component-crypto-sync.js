(function()  {
    'use strict';

    Vue.component('component-crypto-sync', {
        props: [
            'propCryptoCurrencies',
            'propCurrency'
        ],

        data: function() {
            return {
                cryptoCurrencies:   JSON.parse(this.propCryptoCurrencies),
                currency:           JSON.parse(this.propCurrency)
            }
        },

        render: function(noTemplate) {
            return noTemplate();
        },

        created: function() {
            this.updatePrices();
        },

        computed: {

            cryptoCurrenciesIds: function() {
                return _.map(this.cryptoCurrencies, 'id')
            },

            updatePricesData: function() {
                return {
                    currency_id:         this.currency.id,
                    crypto_currency_ids: this.cryptoCurrenciesIds
                }
            }
        },

        methods: {

            /**
             * Events
             */

            onUpdatedPrices: function(response) {
                _.each(response.data, function(data) {
                    window.bus.$emit('cryptoSync:updated:' + data.crypto_currency_id, {
                        data: data
                    });
                });

                setTimeout(this.updatePrices.bind(this), 10000);
            },

            onFailedUpdatePrices: function(error) {
                setTimeout(this.updatePrices.bind(this), 15000);
            },

            /**
             * Methods
             */

            updatePrices: function() {

                if (!this.cryptoCurrencies.length) {
                    return;
                }

                axios
                .post('/market_exchange.json', this.updatePricesData)
                .then(this.onUpdatedPrices.bind(this))
                .catch(this.onFailedUpdatePrices.bind(this));
            }

        },

    });

}());
