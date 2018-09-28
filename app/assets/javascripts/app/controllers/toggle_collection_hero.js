/**
 * ToggleCollectionHero
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        drawer: null,

        /**
         * Boot
         */

        initialize: function () {
            this.subscribeFinderRefreshProducts();
        },


        /**
         * Listeners
         */

        subscribeFinderRefreshProducts: function () {
            $(document).on('finder:refreshProducts', this.onFinderRefreshProducts.bind(this));
        },

        /**
         * Callbacks
         */

        onFinderRefreshProducts: function () {
            var template = this.templateDefaultHero();

            $(this.element).html(template);
            this.disconnect();
        },

        /**
         * Templates
         */

        // TODO: Could be improved
        templateDefaultHero: function () {
            return [
                '<h1 class="hero__title">Find your next Soylent.</h1>',
                '<h2 class="hero__subtitle">Discover the best Soylent alternatives based on the protein ratio, shipping, pricing per month and other metrics.</h2>',
            ].join('')
        }
    });

    window.app.stimulus.register('toggleCollectionHero', Controller);
}());
