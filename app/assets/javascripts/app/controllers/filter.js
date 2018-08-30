/**
 * Filters
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        emitCreated: function () {
            $(document).trigger('filter:created', {
                property: this.data.get('property'),
                propertyChecked: this.isPropertyChecked()
            });
        },

        emitUpdated: function () {
            $(document).trigger('filter:updated', {
                property: this.data.get('property'),
                propertyChecked: this.isPropertyChecked()
            });
        },

        initialize: function () {
            this.emitCreated();

            if (this.isPropertyChecked()) {
                this.toggleSelected($(this.element));
            }
        },

        isPropertyChecked: function () {
            return _.castBool(this.data.get('propertyChecked'));
        },

        toggleSelected: function ($filter) {
            $filter.toggleClass('filters__item--selected');
        },

        togglePropertyChecked: function () {
            var newPropertyChecked = !this.isPropertyChecked();

            this.data.set('propertyChecked', newPropertyChecked);
        },

        onClickFilter: function (event) {
            var $filter = $(event.currentTarget);

            event.preventDefault();

            this.toggleSelected($filter);
            this.togglePropertyChecked();

            this.emitUpdated();
        }
    });

    window.app.stimulus.register('filter', Controller);
}());
