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

        initialize: function () {
        },

        showSuccess: function () {
            swal({
                title: 'You\'ve Subscribed',
                text: 'We will notify you :)',
                icon: 'success'
            });

            $(this.newsletterTarget).remove();

            document.cookie = "signed_up_newsletter=true"
        },

        showError: function (response) {
            swal({
                title: 'Oops!',
                text: response.errors,
                icon: 'error'
            });
        },

        onRequestNewslettersDone: function (response) {
            response.success ? this.showSuccess() : this.showError(response);
        },

        onSubmit: function (e) {
            var email = $(this.emailTarget).val();

            e.preventDefault();

            if (_.isEmpty(email)) { return; }

            $.post('/api/newsletters', {email: email}).done(this.onRequestNewslettersDone.bind(this));
        }

    });

    window.app.stimulus.register('newsletter', Controller);
}());
