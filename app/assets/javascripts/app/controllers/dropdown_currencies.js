(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to toggle the panel
     * currencies when clicking on the coin header
     */

    var Controller = new Class({

        extends: Stimulus.Controller,

        onClickCurrency: function (e) {
            e.preventDefault();
            $('#dropdown-currencies').slideToggle('fast');
        }
    });

    window.app.stimulus.register('dropdown-currencies', Controller);
}());
