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
            if (!_.isNull(currentModal)) {
                currentModal.close();
            }

            currentModal = new tingle.modal(options);
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
            .done(function (html) { create(html, options) })
            .fail(function () { create(TEMPLATES.error, options) });
        };

    window.app.services.modal = {
        create: create,
        createFromUrl: createFromUrl,
        current: function () {
            return currentModal;
        }
    };
}());
