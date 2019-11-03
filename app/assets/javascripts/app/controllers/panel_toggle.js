(function() {
    'use strict';

    /**
     * @description
     * This controller is in charge to open the panel filters on mobile (Browse products)
     */

    window.app.stimulus.register('panel-toggle', new Class({


        extends: Stimulus.Controller,

        static: {
            targets: ['trigger', 'panel']
        },

        initialize: function () {
            $(this.panelTarget).hide();
        },

        toggle: function () {
            if (!window.app.services.breakpoints.isSmallerThan('x-wide')) { return; }

            $(this.triggerTarget).toggleClass('opened');
            $(this.panelTarget).toggle();
        }
    }));
}());
