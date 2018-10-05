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
            $(this.element).on('change', this.onChangeNarrow.bind(this));
        },

        /**
         * Emitters
         */

        emitCreated: function () {
            $(document).trigger('narrow:created', {
                property: $(this.element).val()
            });
        },

        emitUpdated: function () {
            $(document).trigger('narrow:updated', {
                property: $(this.element).val()
            });
        },

        /**
         * Callbacks
         */

        onChangeNarrow: function () {
            this.emitUpdated();
        }
    });

    window.app.stimulus.register('narrow', Controller);
}());
