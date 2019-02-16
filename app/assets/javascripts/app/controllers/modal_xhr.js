(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to remotely load the content of the href given
     * within a modal.
     */

    var Controller = new Class({

        extends: Stimulus.Controller,
        currentModal: null,
        content: null,

        initialize: function () {
            $(this.element).on('click', this.onClickElement.bind(this));
        },

        onClickElement: function (e) {
            e.preventDefault();

            if (this.hasAlreadyLoadedContent()) {
                this.showModal();
                return;
            }

            this.showWaitingModal();
            this.requestContent().done(this.onDoneRequestContent.bind(this));
        },

        onDoneRequestContent: function (content) {
            this.content = content;
            this.showModal();
        },

        hasAlreadyLoadedContent: function () {
            return !_.isEmpty(this.content);
        },

        requestContent: function () {
            var url = $(this.element).attr('href');

            return $.get(url);
        },

        createWaitingModal: function () {
            return new tingle.modal({
                closeMethods: [] // Can't close.
            });
        },

        createModal: function () {
            return new tingle.modal();
        },

        showWaitingModal: function () {
            this.currentModal = this.createWaitingModal();
            this.currentModal.setContent(this.templateLoading());
            this.currentModal.open();
        },

        showModal: function () {
            this.currentModal.close();
            this.currentModal = this.createModal();
            this.currentModal.setContent(this.content);
            this.currentModal.open();
        },

        templateLoading: function () {
            // TODO: Improve with EJS templates or similar.
            return [
                '<div class="spinner">',
                    '<div class="spinner__bounce spinner__bounce--first"></div>',
                    '<div class="spinner__bounce spinner__bounce--second"></div>',
                    '<div class="spinner__bounce spinner__bounce--third"></div>',
                '</div>'
            ].join('')
        }
    });

    window.app.stimulus.register('modal-xhr', Controller);
}());
