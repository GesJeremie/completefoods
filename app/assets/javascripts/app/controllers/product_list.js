/**
 * ProductList
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: ['container']
        },

        /**
         * Boot
         */

        initialize: function () {
            this.subscribeListeners();
        },

        subscribeListeners: function () {
            $(document).on('finder:refreshProductsAttempted', this.onRefreshProductsAttempted.bind(this));
            $(document).on('finder:refreshProducts', this.onRefreshProducts.bind(this));
        },

        emitRefreshed: function () {
            $(document).trigger('productList:refreshed');
        },

        /**
         * Callbacks
         */

        onRefreshProductsAttempted: function () {
            $(this.containerTarget).addClass('product-list--refreshing');
        },

        onRefreshProducts: function (event, response) {
            $(this.containerTarget)
                .html(response.products)
                .removeClass('product-list--refreshing');

            this.emitRefreshed();
        }
    });

    window.app.stimulus.register('productList', Controller);
}());
