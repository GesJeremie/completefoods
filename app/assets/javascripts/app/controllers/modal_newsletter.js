(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to open the newsletter modal
     */

    window.app.stimulus.register('modal-newsletter', new Class({

        DELAY_BEFORE_TO_SHOW_NEWSLETTER: window.app.config.modalNewsletter.delayBeforeToShow,
        COOKIE_EXPIRATION_TIME: window.app.config.modalNewsletter.cookieExpirationTime,

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        initialize: function () {
            if (window.app.services.breakpoints.isSmallerThan('wide')) { return; }
            if (Cookies.get('newsletter_opened')) { return; }

            this.waitAndShowNewsletter();
        },

        waitAndShowNewsletter: function () {
            setTimeout(this.showNewsletter, this.DELAY_BEFORE_TO_SHOW_NEWSLETTER);
        },

        showNewsletter: function () {
            Cookies.set('newsletter_opened', true, { expires: this.COOKIE_EXPIRATION_TIME });

            window.app.services.modal.createFromUrl(Routes.newsletterPath(), {
                closeMethods: ['button'],
                cssClass: ['tingle-modal--newsletter']
            });
        }
    }));
}());
