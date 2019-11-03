(function() {
    'use strict';

    window.app.stimulus.register('reviews-form', new Class({
        extends: Stimulus.Controller,

        static: {
            targets: ['upvote', 'downvote', 'reason']
        },

        initialize: function () {
            $(this.upvoteTarget).on('click', this.onUpvote.bind(this));
            $(this.downvoteTarget).on('click', this.onDownvote.bind(this));

        },

        onUpvote: function () {
            this.setReasonPlaceholder('Why do you recommend this product? (very short reviews are allowed)');
            this.focusReason();
        },

        onDownvote: function () {
            this.setReasonPlaceholder('Why do you not recommend this product? (very short reviews are allowed)');
            this.focusReason();
        },

        setReasonPlaceholder: function (placeholder) {
            $(this.reasonTarget).attr('placeholder', placeholder);
        },

        focusReason: function () {
            $(this.reasonTarget).focus();
        }
    }));
}());
