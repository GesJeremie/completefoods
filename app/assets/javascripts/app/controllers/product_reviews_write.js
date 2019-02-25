/*
(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        request: null,

        static: {
            targets: ['errors', 'submit', 'productId']
        },



        emitReviewAdded: function () {
            $(document).trigger('productReviewsWrite:reviewAdded', {
                productId: this.getProductId()
            });
        },

        getProductId: function () {
            return $(this.productIdTarget).val();
        },



        showSuccess: function () {
            swal({
                title: 'Success',
                text: 'Thanks for your review!',
                icon: 'success'
            });
        },

        showError: function (error) {
            swal({
                title: 'Ooops',
                text: error,
                icon: 'error'
            })
        },

        enableSubmit: function () {
            this.request = null;
            $(this.submitTarget).prop('disabled', false);
        },

        disableSubmit: function () {
            $(this.submitTarget).prop('disabled', true);
        },


        onSubmit: function (event) {
            event.preventDefault();

            var params = $(this.element).serialize();

            if (this.request) { return; }

            this.disableSubmit();
            this.request = $.post('/api/product_reviews', params, this.onRequestDone.bind(this));

        },

        onRequestDone: function (response) {
            this.enableSubmit();

            if (!response.success) {
                this.showError(response.errors);
                return;
            }

            this.showSuccess();
            this.emitReviewAdded();
            $(this.element).remove();
        }

    });

    window.app.stimulus.register('product-reviews-write', Controller);
}());
*/
