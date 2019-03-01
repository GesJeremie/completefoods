(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to open the newsletter modal
     */

    window.app.stimulus.register('modal-newsletter', new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        initialize: function () {
            if (window.app.services.breakpoint.isSmallerThan('wide')) { return; }
            if (Cookies.get('newsletter_opened')) { return; }

            this.waitAndShowNewsletter();
        },

        waitAndShowNewsletter: function () {
            setTimeout(this.showNewsletter, window.app.config.delayBeforeToShowNewsletter);
        },

        showNewsletter: function () {
            Cookies.set('newsletter_opened', true, { expires: 7 });

            window.app.services.modal.createFromUrl(Routes.newsletterPath(), {
                closeMethods: ['button'],
                cssClass: ['tingle-modal--newsletter']
            });
        }
    }));
}());
