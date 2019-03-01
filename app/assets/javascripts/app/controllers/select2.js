(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to initialize the plugin select2
     * to prettify the selects when the window is larger than medium.
     */

    window.app.stimulus.register('select2', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            if (window.app.services.breakpoint.isSmallerThan('medium')) { return; }

            $('select').select2({
                minimumResultsForSearch: -1
            });
        }
    }));
}());
