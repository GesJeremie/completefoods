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

            this.pendingRequest = this.makeRequestRefreshResults();
        },

        makeRequestRefreshResults: function () {
            this.toggleLoading();

            return $.get(
                Routes.productsPath(),
                $(this.element).serialize()
            )
            .always(function () {
                this.toggleLoading();
                this.pendingRequest = false;
            }.bind(this))
            .done(
                this.showNewResults.bind(this)
            )
            .fail(
                this.showError.bind(this)
            );
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
        }
    }));
}());
