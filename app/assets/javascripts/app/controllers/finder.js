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


        refreshProducts: function () {
            var filters, sort, params;

            this.emitRefreshProductsAttempted();

            if (this.requestProducts) {
                this.requestProducts.abort();
            }

            filters = _.pickBy(this.filters, function (filter) { return filter === true });
            sort = {sort: this.sort};

            params = _.merge(filters, sort);

            this.requestProducts = $.get('/api/products.json', params).done(this.onRequestProductsDone.bind(this));
        }
    });

    window.app.stimulus.register('finder', Controller);
}());
