(function() {
    'use strict';

    window.app.stimulus.register('table', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            $(this.element).DataTable({
                pageLength: 30
            });
        }
    }));
}());
