(function() {
    'use strict';

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
