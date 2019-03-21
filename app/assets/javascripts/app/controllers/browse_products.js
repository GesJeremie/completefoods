(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to refresh the product results when a filter / search
     * is applied.
     */

    window.app.stimulus.register('browse-products', new Class({

        extends: Stimulus.Controller,

        static: {
            targets: [
                'productResults'
            ]
        },

        pendingRequest: false,

        initialize: function () {
            $(this.element).find('input').on('change input submit', this.refreshResults.bind(this));
        },

        refreshResults: function (event) {
            event.preventDefault();

            if (this.pendingRequest) {
                this.pendingRequest.abort();
            }

            this.pendingRequest = this.makeRequest();
        },

        makeRequest: function () {
            this.toggleLoading();

            return $.get(
                this.getUrlRequest()
            )
            .always(
                this.onAlways.bind(this)
            )
            .done(
                this.onDone.bind(this)
            )
            .fail(
                this.onFail.bind(this)
            );
        },

        onAlways: function () {
            this.toggleLoading();
            this.pendingRequest = false;
        },

        onDone: function (responseContent) {
            this.refreshBrowserUrl();
            this.showNewResults(responseContent);
        },

        onFail: function () {
            this.showError();
        },

        toggleLoading: function () {
            $(this.productResultsTarget).toggleClass('product-results--refreshing');
        },

        showNewResults: function (responseContent) {
            var $responseContent = $('<div>' + responseContent + '</div>'),
                $results = $responseContent.find('[data-target="browse-products.productResults"]').html();

            $(this.productResultsTarget).html($results);
        },

        showError: function () {
            // TODO: Implement.
        },

        getUrlRequest: function () {
            var payload = $(this.element).serialize();

            return Routes.productsPath(payload);
        },

        refreshBrowserUrl: function () {
            window.history.pushState({}, null, this.getUrlRequest());
        }
    }));
}());
