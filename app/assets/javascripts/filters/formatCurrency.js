(function() {
    'use strict';

    Vue.filter('formatCurrency', function(value) {
        return numeral(value).format('0,0.00');
    });

}());
