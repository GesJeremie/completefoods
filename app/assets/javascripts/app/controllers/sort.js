/**
 * Sort
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

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

        initialize: function () {
            $(this.element).select2({
                minimumResultsForSearch: -1
            });

            this.emitCreated();
            this.events();
        },

        events: function () {
            $(this.element).on('change', this.onChangeSort.bind(this));
        },

        onChangeSort: function () {
            this.emitUpdated();
        }
    });

    window.app.stimulus.register('sort', Controller);
}());
