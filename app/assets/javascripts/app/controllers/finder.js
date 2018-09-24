/**
 * Finder
 */

(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to request the list of products needed
     * based on the search params (filters, narrow ...) of the drawer finder.
     */

    var Controller = new Class({

        extends: Stimulus.Controller,

        filters: {},
        madeIn: null,
        sort: null,
        narrow: null,

        requestProducts: null,

        /**
         * Boot
         */

        initialize: function () {
            this.subscribeListeners();
        },

        /**
         * Listeners
         */

        listeners: [
            'filter:created',
            'filter:updated',
            'sort:created',
            'sort:updated',
            'narrow:created',
            'narrow:updated',
            'madeIn:created',
            'madeIn:updated'
        ],

        subscribeListeners: function () {
            _.each(this.listeners, this.subscribeListener.bind(this));
        },

        subscribeListener: function (listener) {
            var method = _.inflectorListenerMethod(listener);

            $(document).on(listener, this[method].bind(this));
        },

        /**
         * Emitters
         */

        emitRefreshProductsAttempted: function () {
            $(document).trigger('finder:refreshProductsAttempted');
        },

        emitRefreshProducts: function (products) {
            $(document).trigger('finder:refreshProducts', {
                products: products
            });
        },

        /**
         * Methods
         */

        refreshProducts: function () {
            if (this.requestProducts) {
                this.requestProducts.abort();
            }

            this.requestProducts = this.getRequestProducts();

            this.emitRefreshProductsAttempted();
            this.refreshUrl();
        },

        refreshUrl: function () {
            var url = '?' + this.buildUrlFromParamsFinder();

            window.history.replaceState(null, null, url);

        },

        getRequestProducts: function () {
            $.get('/api/products.json', this.getParamsFinder()).done(this.onRequestProductsDone.bind(this));
        },

        getParamsFinder: function () {
            return _.merge(this.availableFilters(), {
                sort: this.sort,
                narrow: this.narrow,
                made_in: this.madeIn
            });
        },

        buildUrlFromParamsFinder: function () {
            var params = this.getParamsFinder();

            return _.map(params, function (value, filter) {
                return filter + '=' + value;
            }).join('&');
        },

        availableFilters: function () {
            return _.pickBy(this.filters, function (filter) {
                return filter === true;
            });
        },

        /**
         * Callbacks
         */

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
        }
    });

    window.app.stimulus.register('finder', Controller);
}());
