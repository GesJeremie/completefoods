(function()  {
    'use strict';

    Vue.component('component-folio', {
        props: [
            'propCurrency'
        ],

        data: function() {
            return {
                cryptos: [],
                price: 0,
                priceHigh24Hours: 0,
                priceLow24Hours: 0,
                currency: JSON.parse(this.propCurrency),
                updatedSeconds: 0
            }
        },

        created: function() {
            this.events();
            setInterval(function() {
                this.updatedSeconds++;
            }.bind(this), 1000);
        },

        computed: {
            humanizePrice: function() {
                return this.price.toFixed(3);
            }
        },

        methods: {
            events: function() {
                window.bus.$on('cryptoCurrencyUpdated', this.onCryptoCurrencyUpdated.bind(this));
            },

            onCryptoCurrencyUpdated: function(crypto) {
                this.updatedSeconds = 0;

                // "_" used to avoid problems with numeric symbols
                // such as the coin "42"
                this.cryptos['_' + crypto.symbol] = {
                    price: crypto.price,
                };

                this.refreshPrices();
            },

            refreshPrices: _.debounce(function() {
                // Could be improved with a reduce
                var price = 0,
                    priceHigh24Hours = 0,
                    priceLow24Hours = 0;

                _.each(_.keys(this.cryptos), function(symbol) {
                    price += this.cryptos[symbol].price;
                    priceHigh24Hours += this.cryptos[symbol].priceHigh24Hours;
                    priceLow24Hours += this.cryptos[symbol].priceLow24Hours;
                }.bind(this));

                this.price = price;
                this.priceHigh24Hours = priceHigh24Hours;
                this.priceLow24Hours = priceLow24Hours;

            }, 300)
        }
    });

}());
