(function()  {
    'use strict';

    Vue.component('component-folio', {
        data: function() {
            return {
                cryptos: [],
                price: 0,
                currency: '$'
            }
        },

        created: function() {
            this.events();
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
                // "_" used to avoid problems with numeric symbols
                // such as the coin "42"
                this.cryptos['_' + crypto.symbol] = crypto.price;

                this.refreshPrice();
            },

            refreshPrice: _.debounce(function() {
                // Could be improved with a reduce
                var price = 0;

                _.each(_.keys(this.cryptos), function(symbol) {
                    price += this.cryptos[symbol];
                }.bind(this));

                this.price = price;
            }, 300)
        }
    });

}());
