(function()  {
    'use strict';

    Vue.component('component-flashes', {
        props: ['error', 'notice', 'success'],

        data: function() {
            return {}
        },

        watch: {
        },

        created: function() {
            // Could be improved with _.each
            if (!_.isEmpty(this.error)) {
                this.showNotification('error', this.error);
                return;
            }

            if (!_.isEmpty(this.notice)) {
                this.showNotification('notice', this.notice);
                return;
            }

            if (!_.isEmpty(this.success)) {
                this.showNotification('success', this.success);
            }
        },

        render: function(h) {
            return h();
        },

        computed: {
        },

        methods: {
            showNotification: function(type, message) {
                new Noty({
                    type: type,
                    text: message,
                    timeout: 5000,
                    theme: 'custom'
                }).show();
            }
        }
    });

}());
