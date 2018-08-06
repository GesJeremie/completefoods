(function() {
    'use strict';

    function castBool(value) {
        return (value.toLowerCase() == 'true');
    }

    _.mixin({'castBool': castBool});

}());
