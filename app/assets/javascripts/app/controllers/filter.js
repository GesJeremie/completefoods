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
                propertyChecked: _.castBool(this.data.get('propertyChecked'))
            });
        },

        emitUpdated: function () {
            $(document).trigger('filter:updated', {
                property: this.data.get('property'),
                propertyChecked: _.castBool(this.data.get('propertyChecked'))
            });
        },

        initialize: function () {
            this.emitCreated();
        },

        toggleSelected: function ($filter) {
            $filter.toggleClass('filters__item--selected');
        },

        togglePropertyChecked: function () {
            var propertyChecked = _.castBool(this.data.get('propertyChecked')),
                newPropertyChecked = !propertyChecked;

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
