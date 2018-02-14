(function()  {
    'use strict';

    Vue.component('component-crypto-currency-actions', {

        data: function() {
            return {
                deleteClicked: false
            }
        },

        methods: {
            onClickDelete: function(e) {
                if (this.deleteClicked) {
                    return;
                }

                e.preventDefault();
                this.deleteClicked = true;
            },

            onClickCancel: function(e) {
                e.preventDefault();
                this.deleteClicked = false;
            }
        }
    });

}());
