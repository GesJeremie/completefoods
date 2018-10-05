(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            this.emitCreated();
            this.events();
        },

        events: function () {
            $(this.element).on('change', this.onChangeSort.bind(this));
        },

        /**
         * Emitters
         */

        emitCreated: function () {
            $(document).trigger('madeIn:created', {
                value: $(this.element).val()
            });
        },

        emitUpdated: function () {
            $(document).trigger('madeIn:updated', {
                value: $(this.element).val()
            });
        },

        /**
         * Callbacks
         */

        onChangeSort: function () {
            this.emitUpdated();
        }
    });

    window.app.stimulus.register('made-in', Controller);
}());
