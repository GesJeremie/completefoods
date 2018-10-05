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
            $(document).trigger('sort:created', {
                property: $(this.element).val()
            });
        },

        emitUpdated: function () {
            $(document).trigger('sort:updated', {
                property: $(this.element).val()
            });
        },

        /**
         * Callbacks
         */

        onChangeSort: function () {
            this.emitUpdated();
        }
    });

    window.app.stimulus.register('sort', Controller);
}());
