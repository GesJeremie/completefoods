(function () {
    'use strict';

    var TEMPLATES = {
            loading: (function () {
                return [
                    '<div class="spinner">',
                        '<div class="spinner__bounce spinner__bounce--first"></div>',
                        '<div class="spinner__bounce spinner__bounce--second"></div>',
                        '<div class="spinner__bounce spinner__bounce--third"></div>',
                    '</div>'
                ].join('')
            }()),

            error: (function () {
                return [
                    '<div class="modal-error">',
                        '<div class="modal-error__description">An error occured!</div>',
                    '</div>'
                ].join('')
            }())
        },

        currentModal = null,

        create = function (html, options = {}) {

            if (!options.replace) {

                if (!_.isNull(currentModal)) {
                    currentModal.close();
                }

                currentModal = new tingle.modal(options);
            }

            currentModal.setContent(html);
            currentModal.open();

            return currentModal;
        },

        createFromUrl = function (url, options = {}) {
            var request = $.get(url);

            create(TEMPLATES.loading, {
                closeMethods: []
            });

            request
            .done(function (html) {
                create(html, options)
            })
            .fail(function () {
                create(TEMPLATES.error, options)
            });
        },

        createFromForm = function ($form, options = {}) {
            var request = $.ajax({
                url: $form.attr('action'),
                method: $form.attr('method'),
                data: $form.serialize()
            });

            request
            .done(function (html) {
                create(html, options)
            })
            .fail(function () {
                create(TEMPLATES.errors, options)
            })
        };

    window.app.services.modal = {
        create: create,
        createFromUrl: createFromUrl,
        createFromForm: createFromForm,
        current: function () {
            return currentModal;
        }
    };
}());
