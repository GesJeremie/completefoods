/**
 * DropdownCurrencies
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: []
        },

        initialize: function () {
        },

        onClickPickCurrency: function (e) {
            e.preventDefault();
            $('#dropdown-currencies').slideToggle('fast');
        }
    });

    window.app.stimulus.register('dropdownCurrencies', Controller);
}());
