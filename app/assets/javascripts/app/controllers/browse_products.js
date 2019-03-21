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
            $(this.element).find('select').on('change', this.refreshResults.bind(this));
        },

        refreshResults: function (event) {
            event.preventDefault();

            if (this.pendingRequest) {
                this.pendingRequest.abort();
            }

            this.enableLoading();
            this.disableButtons();

            this.pendingRequest = this.makeRequest();
        },

        makeRequest: function () {
            return $.get(
                Routes.productsPath(),
                this.getPayload()
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
            this.disableLoading();
            this.enableButtons();
            this.pendingRequest = false;
        },

        onDone: function (responseContent) {
            this.refreshBrowserUrl();
            this.showNewResults(responseContent);
        },

        onFail: function () {
            this.showError();
        },

        enableLoading: function () {
            $(this.productResultsTarget).addClass('product-results--refreshing');
        },

        disableLoading: function () {
            $(this.productResultsTarget).removeClass('product-results--refreshing');
        },

        enableButtons: function () {
            $(this.element).find('button[type="submit"]').removeAttr('disabled');
        },

        disableButtons: function () {
            $(this.element).find('button[type="submit"]').attr('disabled', true);
        },

        showNewResults: function (responseContent) {
            var $responseContent = $('<div>' + responseContent + '</div>'),
                $results = $responseContent.find('[data-target="browse-products.productResults"]').html();

            $(this.productResultsTarget).html($results);
        },

        showError: function () {
            // TODO: Implement.
        },

        getPayload: function () {
            return $(this.element).serialize();
        },

        refreshBrowserUrl: function () {
            var url = '/products?' + this.getPayload();

            window.history.pushState({}, null,  url);
        }
    }));
}());
