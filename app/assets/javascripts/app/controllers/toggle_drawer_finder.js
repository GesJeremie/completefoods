(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        drawer: null,

        /**
         * Boot
         */

        initialize: function () {
            this.drawer = $('#drawer-finder').drawer();
        },

        /**
         * Callbacks
         */

        onClickButton: function () {
            this.drawer.drawer('toggle');
        }
    });

    window.app.stimulus.register('toggle-drawer-finder', Controller);
}());
