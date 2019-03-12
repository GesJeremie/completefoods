(function () {
    'use strict';

    var TEMPLATES = {
            loading: JST['app/templates/modal_loading'],
            error: JST['app/templates/modal_error']
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

            create(TEMPLATES.loading(), {
                closeMethods: []
            });

            request
            .done(function (html) {
                create(html, options)
            })
            .fail(function () {
                create(TEMPLATES.error(), options)
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
                create(TEMPLATES.error(), options)
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
