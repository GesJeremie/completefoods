/**
 * Filters
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        filters: {},

        requestProducts: null,

        subscribeFilterCreated: function () {
            $(document).on('filter:created', this.onFilterCreated.bind(this));
        },

        subscribeFilterUpdated: function () {
            $(document).on('filter:updated', this.onFilterUpdated.bind(this));
        },

        emitRefreshProductsAttempted: function () {
            $(document).trigger('filters:refreshProductsAttempted');
        },

        emitRefreshProducts: function (products) {
            $(document).trigger('filters:refreshProducts', {
                products: products
            });
        },

        initialize: function () {
            this.subscribeFilterCreated();
            this.subscribeFilterUpdated();
        },

        onRequestProductsDone: function (response) {
            this.emitRefreshProducts(response.content);
        },

        onFilterCreated: function (event, filter) {
            this.filters[filter.property] = filter.propertyChecked;
        },

        onFilterUpdated: function (event, filter) {
            this.filters[filter.property] = filter.propertyChecked;
            this.emitRefreshProductsAttempted();

            if (this.requestProducts) {
                this.requestProducts.abort();
            }

            var filters = _.pickBy(this.filters, function (filter) { return filter === true });

            this.requestProducts = $.get('/api/products.json', filters).done(this.onRequestProductsDone.bind(this));
        }
    });

    window.app.stimulus.register('filters', Controller);
}());
