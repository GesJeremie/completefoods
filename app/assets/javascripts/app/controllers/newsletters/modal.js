(function() {
    'use strict';

    window.app.stimulus.register('newsletter-modal', new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        initialize: function () {
            this.waitAndShowNewsletter();
        },

        waitAndShowNewsletter: function () {
            setTimeout(this.showNewsletter, window.app.config.delayBeforeToShowNewsletter);
        },

        showNewsletter: function () {
            window.app.services.modal.createFromUrl(Routes.newsletterPath(), {
                closeMethods: ['button'],
                cssClass: ['tingle-modal--newsletter']
            });
        }
    }));
}());
