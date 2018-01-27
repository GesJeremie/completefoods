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

        computed: {
        },

        methods: {
            onClickCurrency: function() {
                window.bus.$emit('settingsCurrencySelected', {
                    id: this.currency.id
                });
            },

            onCurrencySelected: function(currency) {
                if (currency.id == this.currency.id) {
                    this.isSelected = true;
                } else {
                    this.isSelected = false;
                }
            }
        }
    });

}());
