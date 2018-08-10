/**
 * Narrow
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

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

        initialize: function () {
            $(this.element).select2();
            this.emitCreated();
            this.events();
        },

        events: function () {
            $(this.element).on('change', this.onChangeNarrow.bind(this));
        },

        onChangeNarrow: function () {
            this.emitUpdated();
        }
    });

    window.app.stimulus.register('narrow', Controller);
}());
