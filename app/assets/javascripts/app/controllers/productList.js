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

        subscribeFinderRefreshProductsAttempted: function () {
            $(document).on('finder:refreshProductsAttempted', this.onRefreshProductsAttempted.bind(this));
        },

        subscribeFinderRefreshProducts: function () {
            $(document).on('finder:refreshProducts', this.onRefreshProducts.bind(this));
        },

        initialize: function () {
            this.subscribeFinderRefreshProductsAttempted();
            this.subscribeFinderRefreshProducts();
        },

        onRefreshProductsAttempted: function () {
            $(this.containerTarget).addClass('product-list--refreshing');
        },

        onRefreshProducts: function (event, response) {
            $(this.containerTarget).html(response.products).removeClass('product-list--refreshing');
        }
    });

    window.app.stimulus.register('productList', Controller);
}());
