(function()  {
    'use strict';

    Vue.component('component-crypto-currency-add', {
        props: [
            'propCryptoCurrencies'
        ],

        data: function() {
            return {
                cryptos: JSON.parse(this.propCryptoCurrencies),
                selected: null
            }
        },

        created: function() {
            this.selected = _.first(this.options);
        },

        computed: {

            options: function() {
                return _.map(this.cryptos, function(crypto) {
                    return {label: crypto.name + ' (' + crypto.symbol + ')', value: crypto.id};
                });
            }
        }
    });

}());
