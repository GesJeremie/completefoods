(function() {
    'use strict';

    Vue.filter('formatCurrency', function(value) {
        value = parseFloat(value);

        if (value > 0 && value < 1) {
            return numeral(value).format('0,0.000');
        }

        return numeral(value).format('0,0.00');
    });

}());
