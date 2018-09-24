/**
 * MadeIn
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            this.setupSelect();
            this.emitCreated();
            this.events();
        },

        // TODO: This method is duplicated in different controllers.
        setupSelect: function () {
            if ($(window).width() < 760) { return; }

            $(this.element).select2({
                minimumResultsForSearch: -1
            });
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

    window.app.stimulus.register('madeIn', Controller);
}());
