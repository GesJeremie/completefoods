(function() {
    'use strict';

    var initializer = {

        init: function () {
            if (this.isMobile()) { return; }

            this.setupSelect2();
        },

        setupSelect2: function () {
            $('select').select2({
                minimumResultsForSearch: -1
            });
        },

        isMobile: function () {
            return $(window).width() < 760;
        }
    };

    initializer.init();
}());
