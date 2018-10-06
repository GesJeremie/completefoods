(function() {
    'use strict';

    var initializer = {

        init: function () {
            this.setupTables();
        },

        setupTables: function () {
            $('table').DataTable({
                pageLength: 30
            });
        }
    };

    initializer.init();
}());
