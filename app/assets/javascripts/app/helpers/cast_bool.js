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

    var mixin = {
        init: function (value) {
            return (value.toLowerCase() == 'true');
        }
    };

    _.mixin({'castBool': function (value) {
        mixin.init(value);
    }});

}());
