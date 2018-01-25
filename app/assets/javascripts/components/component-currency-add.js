(function()  {
    'use strict';

    Vue.component('component-currency-add', {
        props: [
            'propCryptoCurrencies'
        ],

        data: function() {
            return {
                cryptos: JSON.parse(this.propCryptoCurrencies),
            }
        },

        computed: {

            options: function() {
                return _.map(this.cryptos, function(crypto) {
                    return {label: crypto.name + ' (' + crypto.symbol + ')', value: crypto.id};
                });
            },

            selected: function() {
                return _.first(this.options);
            }
        }
    });

}());
