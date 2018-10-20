(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: ['container']
        },

        /**
         * Boot
         */

        initialize: function () {
            this.subscribeListeners();
        },

        subscribeListeners: function () {
            $(document).on('productReviewsWrite:reviewAdded', this.onReviewAdded.bind(this));
        },

        emitRefreshed: function () {
            $(document).trigger('productReviewsList:refreshed');
        },

        /**
         * Callbacks
         */

        onReviewAdded: function (event, data) {
            $.get('/api/product_reviews/' + data.productId, this.onFetchProductReviewsDone.bind(this));
        },

        onFetchProductReviewsDone: function (response) {
            $(this.element).html(response.content);
            this.emitRefreshed();
        }
    });

    window.app.stimulus.register('product-reviews-list', Controller);
}());
