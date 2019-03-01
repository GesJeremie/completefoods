(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to toggle the header menu on mobile
     */

    window.app.stimulus.register('header-menu', new Class({

        extends: Stimulus.Controller,

        static: {
            targets: ['links', 'currency']
        },

        /**
         * Boot
         */

        initialize: function () { },

        /**
         * Methods
         */

        toggleMenu: function () {
            $(this.linksTarget).toggle();
            $(this.currencyTarget).toggle();
        },

        /**
         * Callbacks
         */

        onClickMenu: function (event) {
            event.preventDefault();

            this.toggleMenu();
        }
    }));
}());
