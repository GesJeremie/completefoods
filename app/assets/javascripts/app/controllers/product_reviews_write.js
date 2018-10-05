(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        request: null,

        static: {
            targets: ['errors']
        },

        /**
         * Callbacks
         */

        onSubmit: function (event) {
            event.preventDefault();

            var params = $(this.element).serialize();

            if (this.request) { return; }

            this.request = $.post('/api/product_reviews', params, this.onRequestDone.bind(this));
        },

        onRequestDone: function (response) {
            if (response.success) {
                $(this.element).html('Thanks for your review!');
                this.disconnect();
            } else {
                $(this.errorsTarget).html(response.errors);
            }
        }

    });

    window.app.stimulus.register('product-reviews-write', Controller);
}());
