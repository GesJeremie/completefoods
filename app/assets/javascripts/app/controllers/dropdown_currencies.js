/**
 * DropdownCurrencies
 */

(function() {
    'use strict';

    /**
     * This controller is in charge to toggle the panel
     * currencies when clicking on the coin header
     */

    var Controller = new Class({

        extends: Stimulus.Controller,

        onClickPickCurrency: function (e) {
            e.preventDefault();
            $('#dropdown-currencies').slideToggle('fast');
        }
    });

    window.app.stimulus.register('dropdownCurrencies', Controller);
}());
