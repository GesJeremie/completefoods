(function() {
    'use strict';

    window.app.stimulus.register('focus', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            $(this.element).focus();
        }
    }));
}());
