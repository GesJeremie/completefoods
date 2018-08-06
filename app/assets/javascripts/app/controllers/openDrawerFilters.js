/**
 * OpenDrawerFilters
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        drawer: null,

        initialize: function () {
            this.drawer = $('#drawer-filters').drawer();
        },

        onClickButton: function () {
            this.drawer.drawer('toggle');
        }
    });

    window.app.stimulus.register('openDrawerFilters', Controller);
}());
