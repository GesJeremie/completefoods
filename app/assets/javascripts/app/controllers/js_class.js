(function() {
    'use strict';

    /**
     * @description
     * This controller adds a class .js
     * to be able to style the app with no javascript in mind
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
