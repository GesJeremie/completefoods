/**
 * ToggleDrawerFinder
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
            this.drawer = $('#drawer-finder').drawer();
        },

        onClickButton: function () {
            this.drawer.drawer('toggle');
        }
    });

    window.app.stimulus.register('toggleDrawerFinder', Controller);
}());
