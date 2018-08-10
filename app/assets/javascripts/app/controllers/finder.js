/**
 * Finder
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        filters: {},

        sort: null,

        requestProducts: null,

        subscribeFilterCreated: function () {
            $(document).on('filter:created', this.onFilterCreated.bind(this));
        },

        subscribeFilterUpdated: function () {
            $(document).on('filter:updated', this.onFilterUpdated.bind(this));
        },

        subscribeSortCreated: function () {
            $(document).on('sort:created', this.onSortCreated.bind(this));
        },

        subscribeSortUpdated: function () {
            $(document).on('sort:updated', this.onSortUpdated.bind(this));
        },

        subscribeNarrowCreated: function () {
            $(document).on('narrow:created', this.onNarrowCreated.bind(this));
        },

        subscribeNarrowUpdated: function () {
            $(document).on('narrow:updated', this.onNarrowUpdated.bind(this));
        },

        emitRefreshProductsAttempted: function () {
            $(document).trigger('finder:refreshProductsAttempted');
        },

        emitRefreshProducts: function (products) {
            $(document).trigger('finder:refreshProducts', {
                products: products
            });
        },

        initialize: function () {
            this.subscribeFilterCreated();
            this.subscribeFilterUpdated();
            this.subscribeSortCreated();
            this.subscribeSortUpdated();
            this.subscribeNarrowCreated();
            this.subscribeNarrowUpdated();
        },

        onRequestProductsDone: function (response) {
            this.emitRefreshProducts(response.content);
        },

        onFilterCreated: function (event, filter) {
            this.filters[filter.property] = filter.propertyChecked;
        },

        onFilterUpdated: function (event, filter) {
            this.filters[filter.property] = filter.propertyChecked;
            this.refreshProducts();
        },

        onSortCreated: function (event, sort) {
            this.sort = sort.property;
        },

        onSortUpdated: function (event, sort) {
            this.sort = sort.property;
            this.refreshProducts();
        },

        onNarrowCreated: function (event, narrow) {
            this.narrow = narrow.property;
        },

        onNarrowUpdated: function (event, narrow) {
            this.narrow = narrow.property;
            this.refreshProducts();
        },

        refreshProducts: function () {
            var filters, params;

            this.emitRefreshProductsAttempted();

            if (this.requestProducts) {
                this.requestProducts.abort();
            }

            filters = _.pickBy(this.filters, function (filter) { return filter === true });

            params = _.merge(filters, {
                sort: this.sort,
                narrow: this.narrow
            });

            this.requestProducts = $.get('/api/products.json', params).done(this.onRequestProductsDone.bind(this));
        }
    });

    window.app.stimulus.register('finder', Controller);
}());
