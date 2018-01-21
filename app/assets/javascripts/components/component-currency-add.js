(function()  {
    'use strict';

    Vue.component('component-currency-add', {
        props: ['cryptoCurrencies'],

        data: function() {
            return {
                cryptos: JSON.parse(this.cryptoCurrencies),
                selected: {label: "ADA (ADA)", value: 1}
            }
        },

        watch: {
        },

        created: function() {
        },

        computed: {

            options: function() {
                return _.map(this.cryptos, function(crypto) {
                    return {label: crypto.name + ' (' + crypto.symbol + ')', value: crypto.id};
                });
            }
        },

        methods: {
        }
    });

}());
