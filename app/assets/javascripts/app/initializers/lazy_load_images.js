(function() {
    'use strict';

    var initializer = {

        init: function () {
            this.events();
            this.lazyLoadImages();
        },

        events: function () {
            $(document).on('productList:refreshed', this.lazyLoadImages);
        },

        lazyLoadImages: function () {
            $('[data-lazy]').lazy();
        }

    };

    initializer.init();
}());
