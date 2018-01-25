(function()  {
    'use strict';

    Vue.component('component-folio', {
        data: function() {
            return {
                price: 0,
                coins: [],
                currency: '$'
            }
        },

        watch: {
        },

        created: function() {
            this.events();
        },

        render: function(h) {
        },

        computed: {
            humanizePrice: function() {
                return this.price.toFixed(3);
            }
        },

        methods: {
            events: function() {
                window.bus.$on('currencyUpdated', function(coin) {
                    this.onCoinUpdated(coin);
                }.bind(this));
            },

            onCoinUpdated: function(coin) {
                var coins = this.coins;

                this.coins[coin.symbol] = coin.price;
                this.currency = coin.currency;

                this.timeElapsed = 0;
                this.refreshPrice();
            },

            refreshPrice: function() {
                var price = 0;

                _.each(_.keys(this.coins), function(symbol) {
                    price += this.coins[symbol];
                }.bind(this));

                this.price = price;
            }
        }
    });

}());
