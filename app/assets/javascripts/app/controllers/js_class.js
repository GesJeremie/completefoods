(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to toggle the header menu on mobile
     */

    window.app.stimulus.register('js-class', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            $(this.element).addClass('js');
        }

    }));
}());
