(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to remotely load the content of the href given
     * within a modal.
     */

    window.app.stimulus.register('modal-button', new Class({

        extends: Stimulus.Controller,

        initialize: function () {
            $(this.element).on('click', this.showModal.bind(this));
        },

        showModal: function (event) {
            var url = $(this.element).attr('href');

            if (_.isEmpty(url)) { return; }

            event.preventDefault();

            window.app.services.modal.createFromUrl(url);
        }
    }));
}());
