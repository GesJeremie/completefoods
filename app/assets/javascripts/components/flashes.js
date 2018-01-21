/*
App.component('flashes', function($scope) {
    'use strict';

    function Flashes() {

        this.$scope = null;

        this.init = function($scope) {
            this.$scope = $scope;
            this.setup();
        };

        this.setup = function() {
            var success = this.$flashes().data('success'),
                error =  this.$flashes().data('error'),
                warning =  this.$flashes().data('warning');

            if (!_.isEmpty(success)) {
                this.showNotification('success', success);
                return;
            }

            if (!_.isEmpty(error)) {
                this.showNotification('error', error);
                return;
            }

            if (!_.isEmpty(warning)) {
                this.showNotification('warning', warning);
            }
        };

        this.showNotification = function(type, message) {
            new Noty({
                type: type,
                text: message,
                timeout: 10000,
                theme: 'custom'
            }).show();
        };

        this.$flashes = function() {
            return this.$scope;
        };
    }


    $('[data-component-flashes]').each(function() {
        new Flashes().init($(this));
    });
});
*/
