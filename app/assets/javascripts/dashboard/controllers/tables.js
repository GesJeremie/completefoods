(function() {
    'use strict';

    window.app.stimulus.register('tables', new Class({

        extends: Stimulus.Controller,

        /**
         * Boot
         */

        initialize: function () {
            $('table').DataTable({
                pageLength: 30
            });
        }
    }));
}());
