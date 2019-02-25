(function() {
    'use strict';

    window.app.stimulus.register('select2', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            if (this.isMobile()) { return; }

            $('select').select2({
                minimumResultsForSearch: -1
            });
        },

        isMobile: function () {
            return $(window).width() < 760;
        }
    }));
}());
