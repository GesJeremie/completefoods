(function()  {
    'use strict';

    Vue.component('component-crypto-currency-actions', {

        data: function() {
            return {
                deleteClicked: false
            }
        },

        computed: {
            textDelete: function() {
                return this.deleteClicked ? 'Are you sure?' : 'Delete'
            }
        },

        methods: {
            onClickDelete: function(e) {
                if (this.deleteClicked) {
                    return;
                }

                e.preventDefault();
                this.deleteClicked = true;
            }
        }
    });

}());
