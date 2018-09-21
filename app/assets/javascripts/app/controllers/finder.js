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
        madeIn: null,
        sort: null,
        narrow: null,

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

        subscribeMadeInCreated: function () {
            $(document).on('madeIn:created', this.onMadeInCreated.bind(this));
        },

        subscribeMadeInUpdated: function () {
            $(document).on('madeIn:updated', this.onMadeInUpdated.bind(this));
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
            this.subscribeMadeInCreated();
            this.subscribeMadeInUpdated();
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

        onMadeInCreated: function (event, madeIn) {
            this.madeIn = madeIn.value;
        },

        onMadeInUpdated: function (event, madeIn) {
            this.madeIn = madeIn.value;
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
                narrow: this.narrow,
                made_in: this.madeIn
            });

            this.requestProducts = $.get('/api/products.json', params).done(this.onRequestProductsDone.bind(this));
            this.refreshUrl(params);
        },

        refreshUrl: function (params) {
            var url = '?' + _.map(params, function (value, filter) { return filter + '=' + value }).join('&');

            window.history.replaceState(null, null, url);

        }
    });

    window.app.stimulus.register('finder', Controller);
}());
