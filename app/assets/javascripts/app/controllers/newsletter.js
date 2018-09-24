/**
 * ProductList
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: ['newsletter','email']
        },

        /**
         * Methods
         */

        showSuccess: function () {
            swal({
                title: 'You\'ve Subscribed',
                text: 'We will notify you :)',
                icon: 'success'
            });

            this.removeNewsletter();
            this.addCookie();
        },

        showError: function (response) {
            swal({
                title: 'Oops!',
                text: response.errors,
                icon: 'error'
            });
        },

        removeNewsletter: function () {
            $(this.newsletterTarget).remove();
        },

        addCookie: function () {
            document.cookie = "signed_up_newsletter=true"
        },

        getEmail: function () {
            return $(this.emailTarget).val();
        },

        hasEmail: function () {
            return _.isEmpty(email);
        },

        /**
         * Callbacks
         */

        onRequestNewslettersDone: function (response) {
            response.success ? this.showSuccess() : this.showError(response);
        },

        onSubmit: function (e) {
            e.preventDefault();

            if (!this.hasEmail()) { return; }

            $.post('/api/newsletters', {email: this.getEmail()}).done(this.onRequestNewslettersDone.bind(this));
        }

    });

    window.app.stimulus.register('newsletter', Controller);
}());
