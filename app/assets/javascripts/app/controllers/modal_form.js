(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to remotely load the content of the form submitted
     * within a modal.
     */

    window.app.stimulus.register('modal-form', new Class({

        extends: Stimulus.Controller,

        initialize: function () {
            $(this.element).on('submit', this.showModal.bind(this));
        },

        showModal: function (event) {
            var $form = $(event.currentTarget),
                options = JSON.parse(this.data.get('options'));

            event.preventDefault();

            window.app.services.modal.createFromForm($form, options);
        }
    }));
}());
