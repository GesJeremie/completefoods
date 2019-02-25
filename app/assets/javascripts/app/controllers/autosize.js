(function() {
    'use strict';

    window.app.stimulus.register('autosize', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            autosize($('[data-autosize]'));
        }
    }));
}());
