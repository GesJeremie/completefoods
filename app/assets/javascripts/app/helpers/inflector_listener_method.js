(function() {
    'use strict';


    /**
     * @description
     * Given a listener name return the method associated
     *
     * @example
     * _.inflectorListenerMethod('filter:updated') // onFilterUpdated
     *
     * @example
     * _.inflectorListenerMethod('sort:created') // onSortCreated
     */

    var mixin = {
        init: function (listener) {
            var segments = listener.split(':');

            return 'on' + this.formatSegments(segments).join('');
        },

        formatSegments: function (segments) {
            return segments.map(function (segment) {
                return _.upperFirst(segment);
            });
        }
    };

    _.mixin({'inflectorListenerMethod': function (value) {
        return mixin.init(value);
    }});

}());
