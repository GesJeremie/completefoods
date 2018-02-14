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
                currency: JSON.parse(this.propCurrency),
                updatedSeconds: 0
            }
        },

        created: function() {
            this.setupTimer();
            this.events();
        },

        computed: {
            humanizePrice: function() {
                return this.price.toFixed(3);
            }
        },

        methods: {
            setupTimer: function() {
                setInterval(this.incrementTimer.bind(this), 1000);
            },

            events: function() {
                window.bus.$on('cryptoCurrencyUpdated', this.onCryptoCurrencyUpdated.bind(this));
            },

            onCryptoCurrencyUpdated: function(crypto) {
                this.resetTimer();

                this.addOrUpdateCryptoCurrency(crypto);
                this.refreshPrices();
            },

            addOrUpdateCryptoCurrency: function(crypto) {
                // "_" used to avoid problems with numeric symbols
                // such as the coin "42"
                this.cryptos['_' + crypto.symbol] = {
                    price: crypto.price,
                };
            },

            refreshPrices: _.debounce(function() {
                // Could be improved with a reduce
                var price = 0;

                _.each(_.keys(this.cryptos), function(symbol) {
                    price += this.cryptos[symbol].price;
                }.bind(this));

                this.price = price;
            }, 300),

            incrementTimer: function() {
                this.updatedSeconds++;
            },

            resetTimer: function() {
                this.updatedSeconds = 0;
            }
        }
    });

}());
