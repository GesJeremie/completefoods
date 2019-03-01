(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to initialize the plugin autosize
     * on the elements given (to make textarea more enjoyable).
     */

    window.app.stimulus.register('autosize', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            autosize($(this.element));
        }
    }));
}());
