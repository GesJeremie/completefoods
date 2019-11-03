(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to give the focus to the element given
     */

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
