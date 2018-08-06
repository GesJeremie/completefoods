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

        subscribeFiltersRefreshProductsAttempted: function () {
            $(document).on('filters:refreshProductsAttempted', this.onRefreshProductsAttempted.bind(this));
        },

        subscribeFiltersRefreshProducts: function () {
            $(document).on('filters:refreshProducts', this.onRefreshProducts.bind(this));
        },

        initialize: function () {
            this.subscribeFiltersRefreshProductsAttempted();
            this.subscribeFiltersRefreshProducts();
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
