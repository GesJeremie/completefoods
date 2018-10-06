(function() {
    'use strict';

    var initializer = {

        init: function () {
            this.setupAutosize();
        },

        setupAutosize: function () {
            autosize($('[data-autosize]'));
        }
    };

    initializer.init();
}());
