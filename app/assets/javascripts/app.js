(function() {
    'use strict';

    var components = [];

    /**
     * Create namespace App
     */
    window.App = window.App || {};


    /**
     * Register the component given
     * @param {String}      The name of the component
     * @param  {Function}   The component function
     */
    window.App.component = function(name, fn) {
       if (_.has(_.keyBy(components, 'name'), name)) {
            throw new Error(
                'app.js - window.App.component: ' +
                'You are trying to register a component with a name which is already taken: '  + name + '.'
            );
        }

        components.push({
            name: name,
            fn: fn
        });
    };

    /**
     * Init each components added
     */
    window.App.initComponents = function($scope) {
        _.invokeMap(_.filter(components, 'fn'), 'fn', $scope);
    };

    /**
     * Init the component wanted
     */
    window.App.initComponent = function(name, $scope) {
        var namedComponents = _.keyBy(components, 'name');

       if (!_.has(namedComponents, name)) {
            throw new Error(
                'app.js - window.App.initComponent: ' +
                'The component: '  + name + ' does not exist.'
            );
       }

       _.invoke(namedComponents, 'fn', $scope);
    };
})();
