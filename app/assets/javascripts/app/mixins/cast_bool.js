(function() {
    'use strict';

    /**
     * @description
     * Cast true / false strings to booleans
     *
     * @example
     * _.castBool('true') // true
     *
     * @example
     * _.castBool('false') // false
     */

    var castBool = function () {
        return (value.toLowerCase() == 'true');
    };

    _.mixin({'castBool': castBool});
}());
