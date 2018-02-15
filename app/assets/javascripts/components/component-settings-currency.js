(function()  {
    'use strict';

    Vue.component('component-settings-currency', {
        mixins: [
            window.mixins.notification
        ],

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

                axios
                .post('/settings_currency', {currency_id: this.currency.id})
                .then(this.onCurrencyPersisted.bind(this))
                .catch(this.onCurrencyErrorPersisted.bind(this));
            },

            onCurrencyPersisted: function(response) {
                this.$notification.show('success', 'Currency updated');
            },

            onCurrencyErrorPersisted: function(error) {
                this.$notification.show('error', 'Impossible to update the currency');
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
