(function()  {
    'use strict';

    Vue.component('component-settings-currency', {

        props: [
            'propCurrency',
            'propCurrencyIdSelected'
        ],

        data: function() {
            return {
                currency: {
                    id: JSON.parse(this.propCurrency).id
                },
                isSelected: false
            }
        },

        created: function() {
            this.isSelected = this.currency.id == this.propCurrencyIdSelected;
            window.bus.$on('settingsCurrencySelected', this.onCurrencySelected.bind(this));
        },

        methods: {
            onClickCurrency: function() {
                window.bus.$emit('settingsCurrencySelected', {
                    id: this.currency.id
                });
            },

            onCurrencySelected: function(currency) {
                this.isSelected = this.isSameCurrency(currency);
            },

            isSameCurrency: function(currency) {
                return currency.id == this.currency.id;
            }
        }
    });

}());
