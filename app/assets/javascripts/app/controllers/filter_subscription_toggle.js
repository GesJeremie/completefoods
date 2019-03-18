(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to toggle the filter "discount for subscription"
     * when the filter "subscription available" is selected.
     */

    window.app.stimulus.register('filter-subscription-toggle', new Class({

        extends: Stimulus.Controller,

        static: {
            targets: [
                'subscriptionAvailable',
                'subscriptionDiscount'
            ]
        },

        initialize: function () {
            this.toggleDiscount();
        },

        toggleDiscount: function () {
            if ($(this.subscriptionAvailableTarget).find('input').is(':checked')) {
                $(this.subscriptionDiscountTarget).show();
            } else {
                $(this.subscriptionDiscountTarget).hide();
            }
        }
    }));
}());
