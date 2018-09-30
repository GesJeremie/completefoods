(function() {
    'use strict';

    // Great place to boot jQuery plugins and stuff like that

    function lazyLoadImages() {
        $('[data-lazy]').lazy();
    }

    $(document).on('productList:refreshed', lazyLoadImages);

    lazyLoadImages();
}());
